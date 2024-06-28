class Sipp < Formula
  desc "Traffic generator for the SIP protocol"
  homepage "https://sipp.sourceforge.net/"
  url "https://github.com/SIPp/sipp.git",
      tag: "v3.7.2",
      revision: "e3b7748d7be7f32dcaeeed5ccd241a342635ac23"
  license "GPL-2.0-or-later"

  bottle :unneeded

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
    system "cmake", "--build", "build", "--verbose"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "SIPp v#{version}", shell_output("#{bin}/sipp -v", 99)
  end
end
