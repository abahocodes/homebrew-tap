class Dojo < Formula
  desc "Coding-interview practice in your terminal, solved in your own editor"
  homepage "https://github.com/abahocodes/dojo"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/abahocodes/dojo/releases/download/v0.5.0/dojo-aarch64-apple-darwin.tar.xz"
      sha256 "10dd2198816a05d8f5240083b524a9d888f3a9fa7a8f54eeab010bf72ed2398a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/abahocodes/dojo/releases/download/v0.5.0/dojo-x86_64-apple-darwin.tar.xz"
      sha256 "fcc74c679b6abfd5632bf10dd4760cbe347b710abfb4a1af303f934fd7e6c77d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/abahocodes/dojo/releases/download/v0.5.0/dojo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6be502f8fb3551ae43bc36524d2e70cf227d923ba544f00659aa2e5357cbbea9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/abahocodes/dojo/releases/download/v0.5.0/dojo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d477c5bee1c977d3189ffaaac27ebf737044aae74ccd2351c609c5f7cc9a3c40"
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
