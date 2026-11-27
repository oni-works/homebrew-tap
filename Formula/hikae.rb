class Hikae < Formula
  desc "A terminal-first, Vim-native Markdown knowledge workspace"
  homepage "https://github.com/oni-works/hikae-releases"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.3/hikae-aarch64-apple-darwin.tar.xz"
      sha256 "8d293cd665b4458bc1a90ebf367b3e1d0f06c917f886d00b3feceffec602d9ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.3/hikae-x86_64-apple-darwin.tar.xz"
      sha256 "915a16ead21a3d4d6c86eedfadb10d50a57434c565014fac405e9c1c2db17bdb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.3/hikae-aarch64-unknown-linux-musl.tar.xz"
      sha256 "760c08ba4c5fe5361030c975b27e4a3050496245e905b7d460b5042e2b3969e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oni-works/hikae-releases/releases/download/v0.1.3/hikae-x86_64-unknown-linux-musl.tar.xz"
      sha256 "b501dfb967238b7cc9c86e72b2702f18d7af720c68ffb92b46791406d18fd379"
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
