
DROP TABLE IF EXISTS smartphone_instagram_posts;
CREATE TABLE IF NOT EXISTS smartphone_instagram_posts (
    id bigint(20) NOT NULL AUTO_INCREMENT,
    profile_id bigint(20) NOT NULL,
    post_id bigint(20) DEFAULT NULL,
    image varchar(255) DEFAULT NULL,
    content varchar(255) DEFAULT NULL,
    created_at bigint(20) NOT NULL,
    comments varchar(50) DEFAULT NULL,
    PRIMARY KEY (id),
    KEY profile_id_index (profile_id),
    KEY post_id_index (post_id)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS smartphone_bank;
CREATE TABLE IF NOT EXISTS smartphone_bank (
    id bigint(20) NOT NULL AUTO_INCREMENT,
    user_id int(11) DEFAULT NULL,
    extrato varchar(255) DEFAULT NULL,
    data varchar(255) DEFAULT NULL,
    PRIMARY KEY (id),
    KEY user_id (user_id)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;