class Hikae < Formula
  desc "A terminal-first, Vim-native Markdown knowledge workspace"
  homepage "https://github.com/oni-works/hikae-releases"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.1/hikae-aarch64-apple-darwin.tar.xz"
      sha256 "3a576be3d744de4a6c5ba691a608e8297ba50bf9d60bfda2d5dadae18159df18"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.1/hikae-x86_64-apple-darwin.tar.xz"
      sha256 "b0239b00f3518a7d6770a07cacb1c973f307eb29ec3720009e6c4c15928cbafd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.1/hikae-aarch64-unknown-linux-musl.tar.xz"
      sha256 "0471780239ebcf145282950c1941abaf4f95cc88379b5968cf209a1a3db3573f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.1/hikae-x86_64-unknown-linux-musl.tar.xz"
      sha256 "4ae25dd3d01a0adb3f6f880f66edfd2342cf68a9aec87216b1f6dcca9ebb28bd"
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
