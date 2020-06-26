# Ecoji 🏣🔉🦐🔼

Ecoji encodes data as 1024 [emojis][emoji].  It's base1024 with an emoji
character set, based off the [original version][ecoji-go] written in Go.

It's also an example of how we can manipulate bit strings in Gleam!

### Encoding:

```rust
import ecoji
import gleam/should

pub fn ecoji_test() {
  "Base64 is so 1999, isn't there something better?\n"
  |> ecoji.encode
  |> should.equal(🏗📩🎦🐇🎛📘🔯🚜💞😽🆖🐊🎱🥁🚄🌱💞😭💮🇵💢🕥🐭🔸🍉🚲🦑🐶💢🕥🔮🔺🍉📸🐮🌼👦🚟🥴📑)
}
```

[emoji]: https://unicode.org/emoji/
[ecoji-go]: https://github.com/keith-turner/ecoji
