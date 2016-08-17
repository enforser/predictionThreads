package Predictions::Library;

#get the most recent post by the user running the script
#saves it in variable "post"
#returns a link object
sub getPost {
	my ($reddit) = @_;
	$posts = $reddit->fetch_links(subreddit=>'test', limit=>'100');
	$post;
	foreach my $currpost (@$posts) {
		if ($currpost->{author} eq $username) {
			return $currpost;
		}
	}
}

1;