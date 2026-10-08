class Dojo < Formula
  desc "Coding-interview practice in your terminal, solved in your own editor"
  homepage "https://github.com/abahocodes/dojo"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/abahocodes/dojo/releases/download/v0.3.0/dojo-aarch64-apple-darwin.tar.xz"
      sha256 "99381e1978aaf86608bff34f6c779e23d612b888aa34ef1f5b4c5c86539497b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/abahocodes/dojo/releases/download/v0.3.0/dojo-x86_64-apple-darwin.tar.xz"
      sha256 "5a4a4fb5195d7cab701ea26c9e7f09060c617d1bb7c33be62d2cbf964106ab0d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/abahocodes/dojo/releases/download/v0.3.0/dojo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "008b794d10b2ed6c6ae53755b5754441d045361c477a512594d27bfbd4dd990c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/abahocodes/dojo/releases/download/v0.3.0/dojo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "14c330af3efc92f488f8ee0c6e7cdaa5768dc2ef294c909db0974076df4e9751"
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
