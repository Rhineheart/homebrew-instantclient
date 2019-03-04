require File.expand_path("../Strategies/cache_wo_download", __dir__)

# A formula that installs the Instant Client Basic Lite package.
class InstantclientBasiclite12 < Formula
  desc "Oracle Instant Client Basic Lite x64"
  homepage "http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html"
  hp = homepage

  url "http://download.oracle.com/otn/mac/instantclient/122010/instantclient-basiclite-macos.x64-12.2.0.1.0-2.zip",
      :using => (Class.new(CacheWoDownloadStrategy) do
                   define_method :homepage do
                     hp
                   end
                 end)
  sha256 "2997f753b61f8b445a241e99412c132feb76cf246dcca2e7837fe82b15c1efb8"

  conflicts_with "instantclient-basic",
                 :because => "Differing versions of same formula"

  def install
    %w[libclntsh.dylib libocci.dylib].each do |dylib|
      ln_s "#{dylib}.12.2", dylib
    end
    lib.install Dir["*.dylib*"]
  end
end
