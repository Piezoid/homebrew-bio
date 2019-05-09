class Kraken2 < Formula
  desc "Taxonomic sequence classification system"
  homepage "https://github.com/DerrickWood/kraken2"
  # URL hack is to bypass audit for word "beta"
  url "https://github.com/DerrickWood/kraken2/archive/v2.0.7-b%65ta.tar.gz"
  version "2.0.7"
  sha256 "baa160f5aef73327e1a79e6d1c54b64b2fcdaee0be31b456f7bc411d1897a744"

  depends_on "blast" # for segmasker + dustmasker

  fails_with :clang # needs openmp

  if OS.mac?
    depends_on "gcc" # for openmp
  else
    depends_on "perl"
  end

  needs :cxx11

  def install
    libexec.mkdir
    system "./install_kraken2.sh", libexec
    libexec_bins = ["kraken2", "kraken2-build", "kraken2-inspect"].map { |x| libexec + x }
    bin.install_symlink(libexec_bins)
    doc.install Dir["docs/*"]
  end

  def caveats
    <<~EOS
      You must build a Kraken2 database before usage.
      See #{HOMEBREW_PREFIX}/share/doc/kraken2/MANUAL.markdown for details.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kraken2 --version 2>&1")
  end
end
