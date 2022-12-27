

# //TODOs Mastodon Postgresql 

 * Setting up
   * [Migrating Postgres off your Mastodon Host](https://www.kujoe.blog/2022/12/migrating-your-mastodon-postgresql.html)
 * Read Replica 
   * [Streaming Replication](https://wiki.postgresql.org/wiki/Streaming_Replication)
   * [High Availabilty, Load Balancing, and Replication](https://www.postgresql.org/docs/current/high-availability.html)
 * Backup and Restore
   * PostgreSQL [Backup and Restore](https://www.postgresql.org/docs/current/backup.html)
   * [How to decide your PostgreSQL backup Strategy](http://www.postgresql-blog.com/postgresql-backup-strategy-recovery-pitr-wal/)

 * Monitoring
   * [PG Hero Montoring](https://github.com/ankane/pghero) 
 * PGBouncer 
   * Need this to keep your connection pools low.

 * Production Postgres:
   * [10 TIps for going into Production](https://severalnines.com/blog/ten-tips-going-production-postgresql/)
     * [Cluster Control has a free option](https://severalnines.com/pricing/#clustercontrol)
     * [Readable Explain Plans](https://explain.depesz.com/)