const std = @import("std");
const input = @embedFile("./input.txt");
const expect = std.testing.expect;

const House = struct {
    x: i32,
    y: i32,
    visit_count: u32,

    pub fn init(x: i32, y: i32) House {
        return House{ .x = x, .y = y, .visit_count = 1 };
    }
};

fn getHouses(comptime length: usize, content: *const [length]u8) std.MultiArrayList(House) {
    const houses = std.MultiArrayList(House);
    var x: i32 = 0;
    var y: i32 = 0;

    // start location is always x=0 y=0
    houses.insert(House.init(x, y));

    for (content) |byte| {
        switch (byte) {
            '<' => x -= 1,
            '>' => x -= 1,
            '^' => y -= 1,
            'v' => y += 1,
            else => unreachable,
        }
        var house_found = false;
        for (houses.items()) |*house| {
            if (house.x == x and house.y == y) {
                house.visit_count.* += 1;
                house_found = true;
            }
        }
        if (!house_found) {
            houses.insert(.{ .x = x, .y = y, .visit_count = 1 });
        }
    }
    return houses;
}

pub fn main() void {
    const houses = getHouses(input.len, input);
    std.log.debug("Square feet: {d}", .{houses.len});
}
