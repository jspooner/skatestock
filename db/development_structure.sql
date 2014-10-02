CREATE TABLE `carts` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `user_id` int(11) default NULL,
  `purchased_at` date default NULL,
  `total_price` float default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `descriptions` (
  `id` int(11) NOT NULL auto_increment,
  `proof_id` int(11) default NULL,
  `master_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `location` varchar(255) default NULL,
  `obsticle` varchar(255) default NULL,
  `trick` varchar(255) default NULL,
  `gender` varchar(255) default NULL,
  `people` varchar(255) default NULL,
  `portrait` tinyint(1) default NULL,
  `age` varchar(255) default NULL,
  `color` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `rider_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `image_shell_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

CREATE TABLE `image_shells` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `description_id` int(11) default NULL,
  `private_base_price` float default NULL,
  `editorial_base_price` float NOT NULL,
  `stock_base_price` float NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `private_sale` int(11) NOT NULL default '0',
  `original_id` int(11) default NULL,
  `stock_id` int(11) default NULL,
  `editorial_id` int(11) default NULL,
  `requires_release` varchar(5) default 'true',
  `state` varchar(200) default 'new',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

CREATE TABLE `image_shells_invitations` (
  `image_shell_id` int(11) default NULL,
  `invitation_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `image_shells_users` (
  `user_id` int(11) default NULL,
  `rider_id` int(11) default NULL,
  `image_shell_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `images` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `product_type` varchar(255) default 'original',
  `parent_id` int(11) default NULL,
  `owner_id` int(11) default NULL,
  `content_type` varchar(255) default NULL,
  `filename` varchar(255) default NULL,
  `thumbnail` varchar(255) default NULL,
  `size` int(11) default NULL,
  `width` int(11) default NULL,
  `height` int(11) default NULL,
  `user_id` int(11) default NULL,
  `description_id` int(11) default NULL,
  `base_price` int(11) default NULL,
  `image_shell_id` int(11) default NULL,
  `image_file_name` varchar(255) default NULL,
  `image_content_type` varchar(255) default NULL,
  `image_file_size` int(11) default NULL,
  `image_updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;

CREATE TABLE `invitations` (
  `id` int(11) NOT NULL auto_increment,
  `first_name` varchar(255) default NULL,
  `last_name` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `phone` varchar(20) default NULL,
  `url` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `permalink` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

CREATE TABLE `invitations_users` (
  `invitation_id` int(11) default NULL,
  `user_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `line_items` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `master_id` int(11) default NULL,
  `use_duration_start` varchar(255) default NULL,
  `use_industry` varchar(255) default NULL,
  `sensitiveSubject` varchar(255) default NULL,
  `use_territory` varchar(255) default NULL,
  `price` float default NULL,
  `price_usage_id` int(11) default NULL,
  `price_media_id` int(11) default NULL,
  `cart_id` int(11) default NULL,
  `image_id` int(11) default NULL,
  `image_shell_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;

CREATE TABLE `line_items_price_options` (
  `line_item_id` int(11) default NULL,
  `price_option_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `payment_notifications` (
  `id` int(11) NOT NULL auto_increment,
  `params` text,
  `cart_id` int(11) default NULL,
  `status` varchar(255) default NULL,
  `transaction_id` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=996332932 DEFAULT CHARSET=latin1;

CREATE TABLE `price_medias` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `price` float NOT NULL,
  `percentage` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `price_usage_id` int(11) default NULL,
  `is_editorial` int(11) default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1;

CREATE TABLE `price_option_names` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

CREATE TABLE `price_options` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `option` varchar(255) default NULL,
  `price` float NOT NULL default '0',
  `price_media_id` int(11) default NULL,
  `percentage` int(11) NOT NULL default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1196 DEFAULT CHARSET=latin1;

CREATE TABLE `price_usages` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `price` float NOT NULL default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

CREATE TABLE `product_categories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `price` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE `product_categories_product_use_durations` (
  `product_category_id` int(11) default NULL,
  `product_use_duration_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `product_categories_product_use_placements` (
  `product_use_placement_id` int(11) default NULL,
  `product_category_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `product_categories_product_use_printruns` (
  `product_category_id` int(11) default NULL,
  `product_use_printrun_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `product_categories_product_use_sizes` (
  `product_category_id` int(11) default NULL,
  `product_use_size_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `product_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `percentage` float default NULL,
  `product_category_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `price` float default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

CREATE TABLE `product_use_durations` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `percentage` float default NULL,
  `price` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

CREATE TABLE `product_use_industries` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `percentage` float default NULL,
  `price` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE `product_use_placements` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `percentage` float default NULL,
  `price` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

CREATE TABLE `product_use_printruns` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `percentage` float default NULL,
  `price` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

CREATE TABLE `product_use_sizes` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `percentage` float default NULL,
  `price` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

CREATE TABLE `requests` (
  `id` int(11) NOT NULL auto_increment,
  `image_id` int(11) default NULL,
  `message` text,
  `request_type` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `image_shell_id` int(11) default NULL,
  `updated_image_id` int(11) default NULL,
  `state` varchar(255) NOT NULL default 'new',
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=434 DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(255) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `activation_code` varchar(40) default NULL,
  `activated_at` datetime default NULL,
  `state` varchar(255) default 'passive',
  `my_group` varchar(255) default 'consumer',
  `deleted_at` datetime default NULL,
  `agreed` int(11) NOT NULL default '0',
  `agreed_to_model_release` int(11) default '0',
  `contact_address` varchar(255) default NULL,
  `contact_city` varchar(255) default NULL,
  `contact_state` varchar(255) default NULL,
  `contact_zip` varchar(10) default NULL,
  `phone` varchar(20) default NULL,
  `first_name` varchar(200) default NULL,
  `last_name` varchar(200) default NULL,
  `job_title` varchar(100) default NULL,
  `company_name` varchar(100) default NULL,
  `fax` varchar(20) default NULL,
  `company_type` varchar(200) default NULL,
  `billing_address` varchar(200) default NULL,
  `billing_city` varchar(200) default NULL,
  `billing_state` varchar(200) default NULL,
  `billing_zip` varchar(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

