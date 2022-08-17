class Unison < Formula
    desc "File synchronization tool for OSX"
    homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
    url "https://github.com/bcpierce00/unison/archive/v2.51.2.tar.gz"
    sha256 "a2efcbeab651be6df69cc9b253011a07955ecb91fb407a219719451197849d5e"
    head "https://github.com/bcpierce00/unison.git", :branch => "master"
  
  
    depends_on "ocaml" => :build
  
    # Upstream fix for compatibility with OCaml 4.08 and later
    # https://github.com/bcpierce00/unison/pull/276
    patch do
      url "https://github.com/bcpierce00/unison/commit/23fa1292.diff?full_index=1"
      sha256 "ad6b28dc2fe1c6c99863079c7e96b12452aa05c05ed010b6c551e32244ce76f2"
    end
  
    def install
      ENV.deparallelize
      ENV.delete "CFLAGS" # ocamlopt reads CFLAGS but doesn't understand common options
      ENV.delete "NAME" # https://github.com/Homebrew/homebrew/issues/28642
      system "make", "UISTYLE=text"
      bin.install "src/unison"
      prefix.install_metafiles "src"
    end
  
    test do
      assert_match version.to_s, shell_output("#{bin}/unison -version")
    end
  end