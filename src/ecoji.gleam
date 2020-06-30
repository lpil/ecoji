import ecoji/table
import gleam/bit_builder.{BitBuilder}
import gleam/bit_string
import gleam/bitwise
import gleam/result
import gleam/string

// This is output when 3 or less input bytes are present.
fn padding() -> UtfCodepoint {
  assert Ok(x) = string.utf_codepoint(9749)
  x
}

// The following paddings are used when only 4 of 5 input bytes are present.
fn padding40() -> UtfCodepoint {
  assert Ok(x) = string.utf_codepoint(9884)
  x
}

fn padding41() -> UtfCodepoint {
  assert Ok(x) = string.utf_codepoint(127949)
  x
}

fn padding42() -> UtfCodepoint {
  assert Ok(x) = string.utf_codepoint(128209)
  x
}

fn padding43() -> UtfCodepoint {
  assert Ok(x) = string.utf_codepoint(128587)
  x
}

fn part1(a, b) -> UtfCodepoint {
  a
  |> bitwise.shift_left(2)
  |> bitwise.or(bitwise.shift_right(b, 6))
  |> table.index_to_emoji
}

fn part2(a, b) -> UtfCodepoint {
  a
  |> bitwise.and(63)
  |> bitwise.shift_left(4)
  |> bitwise.or(bitwise.shift_right(b, 4))
  |> table.index_to_emoji
}

fn part3(a, b) -> UtfCodepoint {
  a
  |> bitwise.and(15)
  |> bitwise.shift_left(6)
  |> bitwise.or(bitwise.shift_right(b, 2))
  |> table.index_to_emoji
}

fn part4(a) -> UtfCodepoint {
  case bitwise.and(a, 3) {
    0 -> padding40()
    1 -> padding41()
    2 -> padding42()
    3 -> padding43()
    _ -> padding40()
  }
}

fn part5(a, b) -> UtfCodepoint {
  a
  |> bitwise.and(3)
  |> bitwise.shift_left(8)
  |> bitwise.or(b)
  |> table.index_to_emoji
}

fn do_encode(bytes: BitString, emojis: BitBuilder) -> BitBuilder {
  case bytes {
    <<>> -> emojis

    <<a:8>> -> {
      let emoji = <<
        part1(a, 0):utf8_codepoint,
        padding():utf8_codepoint,
        padding():utf8_codepoint,
        padding():utf8_codepoint,
      >>
      bit_builder.append(emojis, emoji)
    }

    <<a:8, b:8>> -> {
      let emoji = <<
        part1(a, b):utf8_codepoint,
        part2(b, 0):utf8_codepoint,
        padding():utf8_codepoint,
        padding():utf8_codepoint,
      >>
      bit_builder.append(emojis, emoji)
    }

    <<a:8, b:8, c:8>> -> {
      let emoji = <<
        part1(a, b):utf8_codepoint,
        part2(b, c):utf8_codepoint,
        part3(c, 0):utf8_codepoint,
        padding():utf8_codepoint,
      >>
      bit_builder.append(emojis, emoji)
    }

    <<a:8, b:8, c:8, d:8>> -> {
      let emoji = <<
        part1(a, b):utf8_codepoint,
        part2(b, c):utf8_codepoint,
        part3(c, d):utf8_codepoint,
        part4(d):utf8_codepoint,
      >>
      bit_builder.append(emojis, emoji)
    }

    <<a:8, b:8, c:8, d:8, e:8, rest:bit_string>> -> {
      let emoji = <<
        part1(a, b):utf8_codepoint,
        part2(b, c):utf8_codepoint,
        part3(c, d):utf8_codepoint,
        part5(d, e):utf8_codepoint,
      >>
      let emojis = bit_builder.append(emojis, emoji)
      do_encode(rest, emojis)
    }
  }
}

pub fn encode(bytes: BitString) -> String {
  bytes
  |> do_encode(bit_builder.from_bit_string(<<>>))
  |> bit_builder.to_bit_string
  |> bit_string.to_string
  |> result.unwrap("")
}
