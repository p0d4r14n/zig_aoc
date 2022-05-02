const std = @import("std");
const input = @embedFile("./input.txt");
const expect = std.testing.expect;

fn bubbleSort(comptime length: usize, data: [length]i32) [length]i32 {
    var sortedData = data;
    var i: usize = 0;
    while (i < length) : (i += 1) {
        var isSwapped = false;
        var j: usize = 0;
        while (j < length - i - 1) : (j += 1) {
            if (sortedData[j] > sortedData[j + 1]) {
                var tmp = sortedData[j];
                sortedData[j] = sortedData[j + 1];
                sortedData[j + 1] = tmp;
                isSwapped = true;
            }
        }
        if (isSwapped == false) {
            break;
        }
    }
    return sortedData;
}

fn calculateFeet(length: i32, width: i32, height: i32) i32 {
    var sides: [3]i32 = .{ length, width, height };
    sides = bubbleSort(sides.len, sides);
    return sides[0] * 2 + sides[1] * 2 + sides[0] * sides[1] * sides[2];
}

fn getTotalFeet(comptime length: usize, content: *const [length]u8) i32 {
    var squareFeet: i32 = 0;
    var lines = std.mem.tokenize(u8, content, "\r\n");
    while (lines.next()) |line| {
        var numbers = std.mem.tokenize(u8, line, "x");
        var measurements: [3]i32 = undefined;
        var i: usize = 0;
        while (numbers.next()) |number| {
            const num = std.fmt.parseInt(i32, number, 10) catch continue;
            measurements[i] = num;
            i += 1;
        }
        squareFeet += calculateFeet(measurements[0], measurements[1], measurements[2]);
    }
    return squareFeet;
}

pub fn main() void {
    std.log.debug("Feet: {d}", .{getTotalFeet(input.len, input)});
}

test "A present with dimensions `2x3x4` requires a total of `34` feet" {
    try expect(calculateFeet(2, 3, 4) == 34);
}

test "A present with dimensions `1x1x10` requires a total of `14` feet" {
    try expect(calculateFeet(1, 1, 10) == 14);
}
