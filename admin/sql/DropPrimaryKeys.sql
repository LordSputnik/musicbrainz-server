\unset ON_ERROR_STOP

-- Alphabetical order

ALTER TABLE album DROP CONSTRAINT album_pkey;
ALTER TABLE albumjoin DROP CONSTRAINT albumjoin_pkey;
ALTER TABLE albummeta DROP CONSTRAINT albummeta_pkey;
ALTER TABLE album_amazon_asin DROP CONSTRAINT album_amazon_asin_pkey;
ALTER TABLE album_cdtoc DROP CONSTRAINT album_cdtoc_pkey;
ALTER TABLE albumwords DROP CONSTRAINT albumwords_pkey;
ALTER TABLE annotation DROP CONSTRAINT annotation_pkey;
ALTER TABLE artist DROP CONSTRAINT artist_pkey;
ALTER TABLE artistalias DROP CONSTRAINT artistalias_pkey;
ALTER TABLE artist_relation DROP CONSTRAINT artist_relation_pkey;
ALTER TABLE artistwords DROP CONSTRAINT artistwords_pkey;
ALTER TABLE automod_election DROP CONSTRAINT automod_election_pkey;
ALTER TABLE automod_election_vote DROP CONSTRAINT automod_election_vote_pkey;
ALTER TABLE cdtoc DROP CONSTRAINT cdtoc_pkey;
ALTER TABLE clientversion DROP CONSTRAINT clientversion_pkey;
ALTER TABLE country DROP CONSTRAINT country_pkey;
ALTER TABLE currentstat DROP CONSTRAINT currentstat_pkey;
ALTER TABLE historicalstat DROP CONSTRAINT historicalstat_pkey;
ALTER TABLE moderation_closed DROP CONSTRAINT moderation_closed_pkey;
ALTER TABLE moderation_note_closed DROP CONSTRAINT moderation_note_closed_pkey;
ALTER TABLE moderation_note_open DROP CONSTRAINT moderation_note_open_pkey;
ALTER TABLE moderation_open DROP CONSTRAINT moderation_open_pkey;
ALTER TABLE moderator DROP CONSTRAINT moderator_pkey;
ALTER TABLE moderator_preference DROP CONSTRAINT moderator_preference_pkey;
ALTER TABLE moderator_subscribe_artist DROP CONSTRAINT moderator_subscribe_artist_pkey;
ALTER TABLE release DROP CONSTRAINT release_pkey;
ALTER TABLE replication_control DROP CONSTRAINT replication_control_pkey;
ALTER TABLE stats DROP CONSTRAINT stats_pkey;
ALTER TABLE track DROP CONSTRAINT track_pkey;
ALTER TABLE trackwords DROP CONSTRAINT trackwords_pkey;
ALTER TABLE trm DROP CONSTRAINT trm_pkey;
ALTER TABLE trm_stat DROP CONSTRAINT trm_stat_pkey;
ALTER TABLE trmjoin DROP CONSTRAINT trmjoin_pkey;
ALTER TABLE trmjoin_stat DROP CONSTRAINT trmjoin_stat_pkey;
ALTER TABLE vote_closed DROP CONSTRAINT vote_closed_pkey;
ALTER TABLE vote_open DROP CONSTRAINT vote_open_pkey;
ALTER TABLE wordlist DROP CONSTRAINT wordlist_pkey;

-- vi: set ts=4 sw=4 et :
