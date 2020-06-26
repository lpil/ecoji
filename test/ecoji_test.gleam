import ecoji
import gleam/should
import gleam/io

pub fn encode_test() {
  <<>>
  |> ecoji.encode
  |> should.equal("")

  <<"a":utf8>>
  |> ecoji.encode
  |> should.equal("👕☕☕☕")

  <<"abc":utf8>>
  |> ecoji.encode
  |> should.equal("👖📸🎈☕")

  <<"6789":utf8>>
  |> ecoji.encode
  |> should.equal("🎥🤠📠🏍")

  <<"XY\n":utf8>>
  |> ecoji.encode
  |> should.equal("🐲👡🕟☕")

  <<"abc6789XY\n":utf8>>
  |> ecoji.encode
  |> should.equal("👖📸🎗🔊🎭🥄📨🏘")

  <<"Base64 is so 1999, isn't there something better?\n":utf8>>
  |> ecoji.encode
  |> should.equal(
    "🏗📩🎦🐇🎛📘🔯🚜💞😽🆖🐊🎱🥁🚄🌱💞😭💮🇵💢🕥🐭🔸🍉🚲🦑🐶💢🕥🔮🔺🍉📸🐮🌼👦🚟🥴📑",
  )
}
