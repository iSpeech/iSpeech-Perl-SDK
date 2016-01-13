use strict;
use MIME::Base64;
use LWP::UserAgent;

my %parameters;
$parameters{'device-type'} = 'perl-sdk-0.1';
$parameters{'apikey'} = 'developerdemokeydeveloperdemokey';
$parameters{'action'} = 'recognize';
$parameters{'locale'} = 'en-US';
$parameters{'freeform'} = '3';
$parameters{'content-type'} = 'wav';
$parameters{'output'} = 'json';

open FILE, "<output.wav";
my $file_contents = do { local $/; <FILE> };

$parameters{'audio'} = encode_base64($file_contents);
$parameters{'audio'} =~ s/\R//g;

my $string = "";
my $key;
my $value;
while (($key, $value) = each(%parameters)){
	$string .= '&'.$key.'='.$value;
}
$string = substr($string, 1);

my $url = 'http://api.ispeech.org/api/rest?'.$string;
my $req = HTTP::Request->new(GET => $url);
my $ua = LWP::UserAgent->new;
my $res = $ua->request($req);

if ($res->code != "200"){ #error occured, print error
	print($res->decoded_content."\n");
}
else{
	print($res->decoded_content."\n");
}