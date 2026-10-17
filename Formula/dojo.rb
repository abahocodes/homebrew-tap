class Dojo < Formula
  desc "Coding-interview practice in your terminal, solved in your own editor"
  homepage "https://github.com/abahocodes/dojo"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/abahocodes/dojo/releases/download/v0.7.0/dojo-aarch64-apple-darwin.tar.xz"
      sha256 "e413b13fe7d430ccc82bb240969363643661b6fdfbba525744db41cf85ab2641"
    end
    if Hardware::CPU.intel?
      url "https://github.com/abahocodes/dojo/releases/download/v0.7.0/dojo-x86_64-apple-darwin.tar.xz"
      sha256 "d25c3b44b1caa6b52a7533b26a9a0b5a96ff9fdcc45f657734247e54a1967f40"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/abahocodes/dojo/releases/download/v0.7.0/dojo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "134b66bb64c13289afca7d3d9d1ba339be80818fc4d55c914c3698df05fe0622"
    end
    if Hardware::CPU.intel?
      url "https://github.com/abahocodes/dojo/releases/download/v0.7.0/dojo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2150a9109e6711a880ae971ba662c79208e7a094b691983b5bff701cc998db51"
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
