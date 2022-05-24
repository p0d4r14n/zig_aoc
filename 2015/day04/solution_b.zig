const std = @import("std");
const input = @embedFile("./input.txt");
const expect = std.testing.expect;

fn findNumber(comptime length: usize, content: *const [length]u8) i32 {
    return std.crypto.hash.Md5.hash(content);  
}

pub fn main() void {
    std.log.debug("Feet: {d}", .{findNumber(input.len, input)});
}

test "A present with dimensions `2x3x4` requires a total of `34` feet" {
    try expect(calculateFeet(2, 3, 4) == 34);
}

test "A present with dimensions `1x1x10` requires a total of `14` feet" {
    try expect(calculateFeet(1, 1, 10) == 14);
}
