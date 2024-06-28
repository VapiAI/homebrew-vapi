class Sipp < Formula
  desc "Traffic generator for the SIP protocol with RTP support"
  homepage "https://sipp.sourceforge.net/"
  url "https://github.com/SIPp/sipp/archive/v3.7.2.tar.gz"
  sha256 "bf21b2bc220145418d0c73262572f2f161c2a297ba02d271d9b72b48a2530240"
  license "GPL-2.0-or-later"

  depends_on "cmake" => :build
  depends_on "openssl@3"
  uses_from_macos "libpcap"
  uses_from_macos "ncurses"

  def install
    args = %w[
      -DUSE_PCAP=1
      -DUSE_SSL=1
      -DUSE_RTP_STREAM=1
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "SIPp v#{version}", shell_output("#{bin}/sipp -v", 99)
  end
end
