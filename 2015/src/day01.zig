const std = @import("std");
const input = @embedFile("../input/day01.txt");

pub fn main() void {
    std.log.debug("{s}", .{input});
}
