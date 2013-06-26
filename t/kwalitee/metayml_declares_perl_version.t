use strict;
use warnings;
use WWW::CPANTS::Test;
use WWW::CPANTS::Analyze;

my @tests = (
  ['T/TO/TOBYINK/Platform-Windows-0.002.tar.gz', 0], # 2206
  ['T/TO/TOBYINK/Platform-Unix-0.002.tar.gz', 0], # 2264
  ['C/CO/COOLMEN/Test-More-Color-0.04.tar.gz', 0], # 2963
  ['A/AN/ANANSI/Anansi-Library-0.02.tar.gz', 0], # 3365
  ['T/TX/TXH/Template-Plugin-Filter-MinifyHTML-0.02.tar.gz', 0], # 3484
  ['H/HI/HITHIM/Socket-Mmsg-0.02.tar.gz', 0], # 3946
  ['S/SM/SMUELLER/Math-SymbolicX-Complex-1.01.tar.gz', 0], # 4719
  ['S/SM/SMUELLER/Math-Symbolic-Custom-CCompiler-1.03.tar.gz', 0], # 5244
  ['L/LT/LTP/Game-Life-0.05.tar.gz', 0], # 6535
  ['K/KP/KPEE/Carp-Growl-0.0.3.tar.gz', 0], # 6682
);

my $mirror = setup_mirror(map {$_->[0]} @tests);

for my $test (@tests) {
  my $tarball = $mirror->file($test->[0]);
  my $analyzer = WWW::CPANTS::Analyze->new;
  my $context = $analyzer->analyze(dist => $tarball);

  my $metric = $analyzer->metric('metayml_declares_perl_version');
  my $result = $metric->{code}->($context->stash);
  is $result => $test->[1], $tarball->basename . " metayml_declares_perl_version: $result";

  if (!$result) {
    my $details = $metric->{details}->($context->stash) || '';
    ok $details, $details;
  }
}

done_testing;
