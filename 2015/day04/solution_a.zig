const std = @import("std");
const input = @embedFile("./input.txt");
const expect = std.testing.expect;

fn findNumber(comptime length: usize, content: *const [length]u8) [16]u8 {
    var out: [16]u8 = undefined;
    var hash = std.crypto.hash.Md5.init(.{});
    hash.update(content);
    hash.final(out[0..]);
    return out;  
}

pub fn main() void {
    std.log.debug("Number: {any}", .{findNumber(input.len, input)[0..]});
}

test "If your secret key is `abcdef`, the answer is `609043`" {
    var a: *const [5]u8 = "abcdef";
    try expect(findNumber(a.len, a)[0..] == 609043);
}

test "If your secret key is `pqrstuv`, the answer is `1048970`" {
    var a: *const [5]u8 = "pqrstuv";
    try expect(findNumber(a.len, a)[0..] == 1048970);
}