const std = @import("std");
const input = @embedFile("./input.txt");
const expect = std.testing.expect;
const Md5 = std.crypto.hash.Md5;

fn findNumber(comptime length: usize, content: *const [length]u8) !usize {
    var out: [16]u8 = undefined;
    var i: usize = 0;
    while (true) : (i += 1) {
        const hash_new: []u8 = try std.fmt.bufPrint(&out, "{s}{}", .{content, i});
        Md5.hash(hash_new, &out, .{});
        if (out[0] == 0 and out[1] == 0 and out[2] == 0) {
            return i;
        }
    }
}

pub fn main() void {
    std.log.debug("Number: {d}", .{findNumber(input.len, input)});
}
