use strict;
use LWP::UserAgent;

my %parameters;
$parameters{'device-type'} = 'perl-sdk-0.1';
$parameters{'apikey'} = 'developerdemokeydeveloperdemokey';
$parameters{'action'} = 'convert';
$parameters{'voice'} = 'usenglishfemale';
$parameters{'format'} = 'mp3';
$parameters{'output'} = 'json';
$parameters{'text'} = 'test';

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
	open FILE, ">output.mp3" or die $!;
	binmode FILE;
	print FILE $res->decoded_content;
	print -s FILE;
	close (FILE);
}