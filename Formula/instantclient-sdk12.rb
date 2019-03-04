require File.expand_path("../Strategies/cache_wo_download", __dir__)

# A formula that installs the Instant Client SDK package.
class InstantclientSdk12 < Formula
  desc "Oracle Instant Client SDK x64"
  homepage "http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html"
  hp = homepage

  url "http://download.oracle.com/otn/mac/instantclient/122010/instantclient-sdk-macos.x64-12.2.0.1.0-2.zip",
      :using => (Class.new(CacheWoDownloadStrategy) do
                   define_method :homepage do
                     hp
                   end
                 end)
  sha256 "e0befca9c4e71ebc9f444957ffa70f01aeeec5976ea27c40406471b04c34848b"

  conflicts_with "instantclient-sdk",
                 :because => "Differing versions of same formula"

  def install
    lib.install ["sdk"]
    # Header files can not be moved out of sdk/include because some software
    # (e.g. ruby-oci8) expects to find them there. Link the header files
    # instead.
    Dir[lib.join("sdk/include/*.h")].each do |header_file|
      include.install_symlink header_file
    end
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <oci.h>

      int main()
      {
        ub4 od = OCI_DEFAULT;
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-o", "test"
    system "./test"
  end
end
