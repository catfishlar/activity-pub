# File Store Options

File Store holds Profile Pictures and Media Attachments 
to posts.   

This tends to be much bigger than the Database store
and can be managed via your NGinx proxy to be somewhere else.
Can even be heirarchical. 

For example 
>       Media usage after 5 days:
>        Attachments:    43.3 GB
>        Custom emoji:   120 MB
>        Preview cards:  999 MB
>        Avatars:        3.22 GB
>        Headers:        7.33 GB

>       =====
>        df:
>        mastodon system: ~10 GB
>        mastodon cache: 65 GB 👾 
>        logs ~4,5 GB
 
From https://dadalo.pl/@dadalo_admin/109478225807324714

But yeah look at this reply.  https://mindly.social/@KuJoe/109478371500218462

And this had a terabyte..  

So the file store is the thing. 


#mastodonadmin

## Local Storage Options

## Object Store Options

 * Use a Nginx proxy https://docs.joinmastodon.org/admin/optional/object-storage-proxy/

 * Communal file store. https://jortage.com/   and https://github.com/jortage/poolmgr

>At first, the easy choice was to set up object storage at DigitalOcean, where the rest 
of our infrastructure is. Yet, if we're being honest here: I underestimated the rate of 
growth, and as it turns out, DigitalOcean performs just fine, but when crossing their free 
tier, it can get expensive. Not for the amount of data stored but for the bandwidth for outgoing traffic.
>
>We will migrate our data to Cloudflare R2, API-compatible with S3, just like DigitalOcean, but cheaper for Egress fees.

from https://github.com/toot-community/blog/blob/main/content/posts/migrating-between-object-storage-providers.md

## Cleaning up

 * [tootctl media remove does not include profile avatars and headers #9567](https://github.com/mastodon/mastodon/issues/9567#issuecomment-1316629364)
