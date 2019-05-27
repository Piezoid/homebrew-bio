class Pugz < Formula
  desc "Truly parallel gzip decompression"
  homepage "https://github.com/Piezoid/pugz"
  url "https://github.com/Piezoid/pugz/archive/97be6839c48878b498112933655506800af3b8e2.tar.gz"
  version "0.8.0"
  sha256 "e0ec4763a9aa64d7ebf333ec333ba72ebfc5797c051a56fd9dd1ce6fca040dc8"

  def install
    system "make", "asserts=0", "V=1"
    bin.install "gunzip" => "pugz"
    pkgshare.install "example"
    doc.install "paper/paper.pdf"
  end

  test do
    assert_match "Chikhi", shell_output("#{bin}/pugz -V 2>&1")
  end
end
