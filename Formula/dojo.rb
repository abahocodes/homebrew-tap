class Dojo < Formula
  desc "Coding-interview practice in your terminal, solved in your own editor"
  homepage "https://github.com/abahocodes/dojo"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/abahocodes/dojo/releases/download/v0.6.0/dojo-aarch64-apple-darwin.tar.xz"
      sha256 "978c2fcfbae9bd4f0f31363d19778d22a412d60469827eb3e5a9070e4b4d3b53"
    end
    if Hardware::CPU.intel?
      url "https://github.com/abahocodes/dojo/releases/download/v0.6.0/dojo-x86_64-apple-darwin.tar.xz"
      sha256 "5601f24d01908779ede945e093496e90e37f11244dc09f4033bd2e098b27a1a5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/abahocodes/dojo/releases/download/v0.6.0/dojo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "332b3323120f9f85ef0cfa087f0381a93c3fab152090d63c23177a8ba1c436cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/abahocodes/dojo/releases/download/v0.6.0/dojo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "46431a0f7e7ad58ffbfef761761e272ce7088678a51d68cc5a217151ab0caba6"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "dojo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dojo"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dojo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dojo"
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
