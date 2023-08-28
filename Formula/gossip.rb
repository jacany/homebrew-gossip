# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Gossip < Formula
  desc "gossip nostr client, rust, egui based."
  homepage "https://github.com/mikedilger/gossip"
  url "https://github.com/mikedilger/gossip.git",
      tag: "v0.7.0",
      revision: "7cbb7f5139fc795d2acbff964ed1af037f4e8057"
  sha256 "1be05143b7c4f560e9baca1dfa89e9fdd47a9ed0188683c751f1ac055ac11607"
  license "MIT"
  head "https://github.com/mikedilger/gossip.git", branch: "master"
  
  option "without-cjk", "Compile with Chinese, Japanese, and Korean Character sets"
  option "without-video", "Compile without Video Playback support"
  option "without-rustls", "Compile without rustls and use native TLS provider"
  
  if build.with? "video"
    depends_on "sdl2"
    depends_on "ffmpeg"
  end
  depends_on "rust" => :build
  depends_on "pkg-config" => :build
  depends_on "cmake" => :build

  livecheck do
    url "https://github.com/mikedilger/gossip"
  end

  def install
    feature_args = ""
    features = Array.new
    if build.without? "rustls"
      feature_args = "--no-default-features "
      features.push("native-tls")
    end
    if build.with? "cjk"
      features.push("lang-cjk")
    end
    if build.with? "video"
      features.push("video-ffmpeg")
    end

    # Add all entries in features into a cargo-compatible flag in feature_args
    if features.length == 1
      feature_args = feature_args + "--features=#{features[0]}"
    elsif features.length > 1
      feature_args = feature_args + "--features=#{features.join(",")}"
    end

    ENV["RUSTUP_TOOLCHAIN"] = "stable"
    ENV["RUSTFLAGS"] = "-C target-cpu=native --cfg tokio_unstable"

    system "cargo", "build", "--release", feature_args, "--locked"
    system "mv", "./target/release", "#{prefix}/bin"
    system "strip", "#{prefix}/bin/gossip"
  end

  # TODO: Write comprehensive tests
end
