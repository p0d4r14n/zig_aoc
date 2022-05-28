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
        if (out[0] == 0 and out[1] == 0 and out[2] >> 4 == 0) {
            return i;
        }
    }
}

pub fn main() void {
    std.log.debug("Number: {d}", .{findNumber(input.len, input)});
}

test "If your secret key is `abcdef`, the answer is `609043`" {
    var a: *const [6]u8 = "abcdef";
    const solution: usize = findNumber(a.len, a) catch 0;
    try expect(solution == 609043);
}

test "If your secret key is `pqrstuv`, the answer is `1048970`" {
    var a: *const [7]u8 = "pqrstuv";
    const solution = findNumber(a.len, a) catch 0; 
    try expect(solution == 1048970);
}