class Hikae < Formula
  desc "A terminal-first, Vim-native Markdown knowledge workspace"
  homepage "https://github.com/oni-works/hikae-releases"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.2/hikae-aarch64-apple-darwin.tar.xz"
      sha256 "582d55999f62e31636f35bbd5c05d9a240dd97b0403ab916066c0dce27a7bee4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.2/hikae-x86_64-apple-darwin.tar.xz"
      sha256 "45266ffdbe19f1cad0c099fcd7b24d509708408f4dbd8b8f05faa8142f1aae64"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.2/hikae-aarch64-unknown-linux-musl.tar.xz"
      sha256 "674215cd5858b0cf825ec5e37d3390a08a0b088be6fe8c9b9dbb3d38b622e3d8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.2/hikae-x86_64-unknown-linux-musl.tar.xz"
      sha256 "3fc5a43ca236729d5e9505231bac27b316cb0dafc8dbbe35bfc6c1532f25e60d"
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
