require File.expand_path("../Strategies/cache_wo_download", __dir__)

# A formula that installs the Instant Client Basic package.
class InstantclientBasic12 < Formula
  desc "Oracle Instant Client Basic x64"
  homepage "http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html"
  hp = homepage

  url "http://download.oracle.com/otn/mac/instantclient/122010/instantclient-basic-macos.x64-12.2.0.1.0-2.zip",
      :using => (Class.new(CacheWoDownloadStrategy) do
                   define_method :homepage do
                     hp
                   end
                 end)
  sha256 "3ed3102e5a24f0da638694191edb34933309fb472eb1df21ad5c86eedac3ebb9"

  conflicts_with "instantclient-basiclite12"

  def install
    %w[libclntsh.dylib libocci.dylib].each do |dylib|
      ln_s "#{dylib}.12.2", dylib
    end
    lib.install Dir["*.dylib*"]
  end
end
