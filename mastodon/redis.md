# Redis Mastodon Considerations

Redis itself can be scaled using either Redis Sentinel or Redis Cluster. 
For Sidekiq, only the Sentinel option is viable, as Sidekiq uses a small number of 
frequently updated keys. With Sentinel, we get fail-over, but we won't increase the 
server's throughput. For the home feed caches, we might use Redis Cluster, which will 
distribute the many cache keyes across available nodes.

Also check https://github.com/mastodon/documentation/blob/master/content/en/admin/scaling.md