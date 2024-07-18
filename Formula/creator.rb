class CreatorAi < Formula
    desc "A self hosted web app for using LLMs with code context"
    homepage "https://github.com/The-Creator-AI/The-Creator-AI"
    # url "https://github.com/The-Creator-AI/The-Creator-AI"
    # sha256 "YOUR_SHA256_HASH"
    license "MIT"
  
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
  