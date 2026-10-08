class Dojo < Formula
  desc "Coding-interview practice in your terminal, solved in your own editor"
  homepage "https://github.com/abahocodes/dojo"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/abahocodes/dojo/releases/download/v0.2.0/dojo-aarch64-apple-darwin.tar.xz"
      sha256 "bd2972de87a18a5887e93e4971a68312abd718e1dfd7a0160e269eb6ca27247d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/abahocodes/dojo/releases/download/v0.2.0/dojo-x86_64-apple-darwin.tar.xz"
      sha256 "5a4b3a49c75abb023ba6f1f433c0421318a3c08fc27bba6cddb78d928cb5cf5a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/abahocodes/dojo/releases/download/v0.2.0/dojo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8a787a4d894eb4409788f8f3e9dfcc722c70dae296d286111c13155fa8b2669b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/abahocodes/dojo/releases/download/v0.2.0/dojo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "af23bbba8d0ba6398555e9d43871a8fca7ea9a5b946e354348a9e80d04c4ab7c"
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
