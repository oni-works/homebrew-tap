class Hikae < Formula
  desc "A terminal-first, Vim-native Markdown knowledge workspace"
  homepage "https://github.com/oni-works/hikae-releases"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.0/hikae-aarch64-apple-darwin.tar.xz"
      sha256 "d2884d0d9ba3b706107ea3e80ef72182cdcc7d6ae8ac4e6fca204d9af6f56009"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.0/hikae-x86_64-apple-darwin.tar.xz"
      sha256 "6e90bb757a36c69c3d3c6285d8388683c01a736f1ddf0ed0cf4a06f9766868b9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.0/hikae-aarch64-unknown-linux-musl.tar.xz"
      sha256 "e349bf152edcb33f5078223dfe08d4a743ef1aa5d82a378363ba5a1444e0c3ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.0/hikae-x86_64-unknown-linux-musl.tar.xz"
      sha256 "e0ce8a23aac8f8babce313daa576a7516269a406aa9d966f95a79f8397534f37"
    end
  end
  license "UNLICENSED"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "hikae"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hikae"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hikae"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hikae"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
