class Creator030 < Formula
    desc "A self hosted web app for using LLMs with code context"
    homepage "https://github.com/The-Creator-AI/The-Creator-AI"
    url "file:///dev/null"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    license "BSD-2-Clause"
  
    depends_on "node"
  
    def install
      # Clone the repositories with specific tags
      system "git", "clone", "-b", "v0.3.0", "--depth", "1", "https://github.com/The-Creator-AI/fe-be-common.git", "fe-be-common"
      cd "fe-be-common"
      system "npm", "install"
      system "npm", "run", "build"

      cd ".."

      system "git", "clone", "-b", "v0.3.0", "--depth", "1", "https://github.com/The-Creator-AI/frontend.git", "frontend"
      cd "frontend"
      system "npm", "install"
      system "npm", "run", "build"

      cd ".."

      system "git", "clone", "-b", "v0.3.0", "--depth", "1", "https://github.com/The-Creator-AI/backend.git", "backend"
      cd "backend"
      system "npm", "install"
      system "npm", "run", "build"

      cd ".."
  
      # Install the 'creator' script
      bin.install "scripts/creator"
    end
  
    test do
      system "#{bin}/creator", "."
    end
  end
  