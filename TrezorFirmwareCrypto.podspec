#
# Be sure to run `pod lib lint trezor-firmware-crypto-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TrezorFirmwareCrypto'
  s.version          = '0.1.0'
  s.summary          = 'Heavily optimized cryptography algorithms for iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ooozws/trezor-firmware-crypto-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ooozws' => 'weisaizhang@gmail.com' }
  s.source           = { :git => 'https://github.com/ooozws/trezor-firmware-crypto-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.prepare_command = <<-CMD
    sed -i '' -e 's:ed25519-donna/::g' ./**/*.c
    sed -i '' -e 's:ed25519-donna/::g' ./**/*.h
    sed -i '' -e 's:USE_ETHEREUM 0:USE_ETHEREUM 1:g' crypto/options.h
  CMD

  s.module_map = 'TrezorFirmwareCrypto.modulemap'
  search_paths = [
    '"${PODS_ROOT}/crypto"',
    '"${PODS_ROOT}/crypto/aes"',
    '"${PODS_ROOT}/crypto/chacha20poly1305"',
    '"${PODS_ROOT}/crypto/ed25519-donna"'
  ]
  s.pod_target_xcconfig = {
    'SWIFT_INCLUDE_PATHS' => '${PODS_ROOT}',
    'OTHER_CFLAGS' => '-O3 -std=c99 -DRAND_PLATFORM_INDEPENDENT',
    'HEADER_SEARCH_PATHS' => search_paths.join(' ')
  }

  s.source_files =
    'TrezorFirmwareCrypto.h',
    'util/SecRandom.m',
    'crypto/*.{c,h}',
    'crypto/aes/*.{c,h}',
    'crypto/chacha20poly1305/*.{c,h}',
    'crypto/ed25519-donna/*.{c,h}'
  s.private_header_files =
    'crypto/aes/aesopt.h',
    'crypto/aes/aestab.h',
    'crypto/ed25519-donna/curve25519-donna-scalarmult-base.h',
    'crypto/ed25519-donna/ed25519-hash-custom-keccak.h',
    'crypto/ed25519-donna/ed25519-hash-custom-sha3.h',
    'crypto/ed25519-donna/ed25519-hash-custom.h',
    'crypto/ed25519-donna/ed25519-keccak.h',
    'crypto/ed25519-donna/ed25519-sha3.h',
    'crypto/bip39_english.h',
    'crypto/blake2_common.h',
    'crypto/check_mem.h',
    'crypto/macros.h',
    'crypto/nem_serialize.h',
    'crypto/rfc6979.h'
  s.exclude_files =
    'crypto/aes/aestst*.{c,h}',
    'crypto/gui/*.{c,h}',
    'crypto/test*.{c,h}',
    'crypto/tools/*.{c,h}'
  s.preserve_path = 'crypto/*.{table}'
  s.libraries = 'c'
end
