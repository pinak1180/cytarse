# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131114154112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "unaccent"

  create_table "oauth_providers", force: true do |t|
    t.text     "name",       null: false
    t.text     "key",        null: false
    t.text     "secret",     null: false
    t.text     "scope"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "strategy"
    t.text     "path"
    t.index ["name"], :name => "oauth_providers_name_unique", :unique => true, :order => {"name" => :asc}
  end

  create_table "channels", force: true do |t|
    t.text     "name",              null: false
    t.text     "description",       null: false
    t.text     "permalink",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "twitter"
    t.text     "facebook"
    t.text     "email"
    t.text     "image"
    t.text     "website"
    t.text     "video_url"
    t.text     "how_it_works"
    t.text     "how_it_works_html"
    t.string   "terms_url"
    t.index ["permalink"], :name => "index_channels_on_permalink", :unique => true, :order => {"permalink" => :asc}
  end

  create_table "users", force: true do |t|
    t.text     "email"
    t.text     "name"
    t.text     "nickname"
    t.text     "bio"
    t.text     "image_url"
    t.boolean  "newsletter",                         default: false
    t.boolean  "project_updates",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                              default: false
    t.text     "full_name"
    t.text     "address_street"
    t.text     "address_number"
    t.text     "address_complement"
    t.text     "address_neighbourhood"
    t.text     "address_city"
    t.text     "address_state"
    t.text     "address_zip_code"
    t.text     "phone_number"
    t.text     "locale",                             default: "pt",  null: false
    t.text     "cpf"
    t.string   "encrypted_password",     limit: 128, default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "twitter"
    t.string   "facebook_link"
    t.string   "other_link"
    t.text     "uploaded_image"
    t.string   "moip_login"
    t.string   "state_inscription"
    t.integer  "channel_id"
    t.index ["channel_id"], :name => "fk__users_channel_id", :order => {"channel_id" => :asc}
    t.index ["email"], :name => "index_users_on_email", :order => {"email" => :asc}
    t.index ["name"], :name => "index_users_on_name", :order => {"name" => :asc}
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true, :order => {"reset_password_token" => :asc}
    t.foreign_key ["channel_id"], "channels", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_users_channel_id"
  end

  create_table "authorizations", force: true do |t|
    t.integer  "oauth_provider_id", null: false
    t.integer  "user_id",           null: false
    t.text     "uid",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["oauth_provider_id"], :name => "fk__authorizations_oauth_provider_id", :order => {"oauth_provider_id" => :asc}
    t.index ["user_id"], :name => "fk__authorizations_user_id", :order => {"user_id" => :asc}
    t.index ["uid", "oauth_provider_id"], :name => "index_authorizations_on_uid_and_oauth_provider_id", :unique => true, :order => {"uid" => :asc, "oauth_provider_id" => :asc}
    t.foreign_key ["oauth_provider_id"], "oauth_providers", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_authorizations_oauth_provider_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_authorizations_user_id"
  end

  create_table "categories", force: true do |t|
    t.text     "name_pt",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_en"
    t.index ["name_pt"], :name => "categories_name_unique", :unique => true, :order => {"name_pt" => :asc}
    t.index ["name_pt"], :name => "index_categories_on_name_pt", :order => {"name_pt" => :asc}
  end

  create_table "projects", force: true do |t|
    t.text     "name",                                null: false
    t.integer  "user_id",                             null: false
    t.integer  "category_id",                         null: false
    t.decimal  "goal",                                null: false
    t.text     "about",                               null: false
    t.text     "headline",                            null: false
    t.text     "video_url"
    t.text     "short_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "about_html"
    t.boolean  "recommended",         default: false
    t.text     "home_page_comment"
    t.text     "permalink",                           null: false
    t.text     "video_thumbnail"
    t.string   "state"
    t.integer  "online_days",         default: 0
    t.datetime "online_date"
    t.text     "how_know"
    t.text     "more_links"
    t.text     "first_backers"
    t.string   "uploaded_image"
    t.string   "video_embed_url"
    t.text     "referal_link"
    t.datetime "sent_to_analysis_at"
    t.index ["category_id"], :name => "index_projects_on_category_id", :order => {"category_id" => :asc}
    t.index ["name"], :name => "index_projects_on_name", :order => {"name" => :asc}
    t.index ["permalink"], :name => "index_projects_on_permalink", :unique => true, :order => {"permalink" => :asc}
    t.index ["user_id"], :name => "index_projects_on_user_id", :order => {"user_id" => :asc}
    t.foreign_key ["category_id"], "categories", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "projects_category_id_reference"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "projects_user_id_reference"
  end

  create_table "rewards", force: true do |t|
    t.integer  "project_id",       null: false
    t.decimal  "minimum_value",    null: false
    t.integer  "maximum_backers"
    t.text     "description",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "reindex_versions"
    t.integer  "row_order"
    t.integer  "days_to_delivery"
    t.index ["project_id"], :name => "index_rewards_on_project_id", :order => {"project_id" => :asc}
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "rewards_project_id_reference"
  end

  create_table "backers", force: true do |t|
    t.integer  "project_id",                            null: false
    t.integer  "user_id",                               null: false
    t.integer  "reward_id"
    t.decimal  "value",                                 null: false
    t.datetime "confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "anonymous",             default: false
    t.text     "key"
    t.boolean  "credits",               default: false
    t.boolean  "notified_finish",       default: false
    t.text     "payment_method"
    t.text     "payment_token"
    t.string   "payment_id"
    t.text     "payer_name"
    t.text     "payer_email"
    t.text     "payer_document"
    t.text     "address_street"
    t.text     "address_number"
    t.text     "address_complement"
    t.text     "address_neighbourhood"
    t.text     "address_zip_code"
    t.text     "address_city"
    t.text     "address_state"
    t.text     "address_phone_number"
    t.text     "payment_choice"
    t.decimal  "payment_service_fee"
    t.string   "state"
    t.text     "referal_link"
    t.index ["key"], :name => "index_backers_on_key", :order => {"key" => :asc}
    t.index ["project_id"], :name => "index_backers_on_project_id", :order => {"project_id" => :asc}
    t.index ["reward_id"], :name => "index_backers_on_reward_id", :order => {"reward_id" => :asc}
    t.index ["user_id"], :name => "index_backers_on_user_id", :order => {"user_id" => :asc}
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "backers_project_id_reference"
    t.foreign_key ["reward_id"], "rewards", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "backers_reward_id_reference"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "backers_user_id_reference"
  end

  create_view "backer_reports", "SELECT b.project_id, u.name, b.value, r.minimum_value, r.description, b.payment_method, b.payment_choice, b.payment_service_fee, b.key, (b.created_at)::date AS created_at, (b.confirmed_at)::date AS confirmed_at, u.email, b.payer_email, b.payer_name, COALESCE(b.payer_document, u.cpf) AS cpf, u.address_street, u.address_complement, u.address_number, u.address_neighbourhood, u.address_city, u.address_state, u.address_zip_code, b.state FROM ((backers b JOIN users u ON ((u.id = b.user_id))) LEFT JOIN rewards r ON ((r.id = b.reward_id))) WHERE ((b.state)::text = ANY ((ARRAY['confirmed'::character varying, 'refunded'::character varying, 'requested_refund'::character varying])::text[]))", :force => true
  create_table "configurations", force: true do |t|
    t.text     "name",       null: false
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], :name => "index_configurations_on_name", :unique => true, :order => {"name" => :asc}
  end

  create_view "backer_reports_for_project_owners", "SELECT b.project_id, COALESCE(r.id, 0) AS reward_id, r.description AS reward_description, (b.confirmed_at)::date AS confirmed_at, b.value AS back_value, (b.value * (SELECT (configurations.value)::numeric AS value FROM configurations WHERE (configurations.name = 'catarse_fee'::text))) AS service_fee, u.email AS user_email, u.name AS user_name, b.payer_email, b.payment_method, COALESCE(b.address_street, u.address_street) AS street, COALESCE(b.address_complement, u.address_complement) AS complement, COALESCE(b.address_number, u.address_number) AS address_number, COALESCE(b.address_neighbourhood, u.address_neighbourhood) AS neighbourhood, COALESCE(b.address_city, u.address_city) AS city, COALESCE(b.address_state, u.address_state) AS state, COALESCE(b.address_zip_code, u.address_zip_code) AS zip_code, b.anonymous FROM ((backers b JOIN users u ON ((u.id = b.user_id))) LEFT JOIN rewards r ON ((r.id = b.reward_id))) WHERE ((b.state)::text = 'confirmed'::text)", :force => true
  create_view "backers_by_periods", "WITH weeks AS (SELECT (generate_series.generate_series * 7) AS days FROM generate_series(0, 7) generate_series(generate_series)), current_period AS (SELECT 'current_period'::text AS series, sum(b.value) AS sum, (w.days / 7) AS week FROM (backers b RIGHT JOIN weeks w ON ((((b.confirmed_at)::date >= ((('now'::text)::date - w.days) - 7)) AND (b.confirmed_at < (('now'::text)::date - w.days))))) WHERE ((b.state)::text <> ALL ((ARRAY['pending'::character varying, 'canceled'::character varying, 'waiting_confirmation'::character varying, 'deleted'::character varying])::text[])) GROUP BY (w.days / 7)), previous_period AS (SELECT 'previous_period'::text AS series, sum(b.value) AS sum, (w.days / 7) AS week FROM (backers b RIGHT JOIN weeks w ON ((((b.confirmed_at)::date >= (((('now'::text)::date - w.days) - 7) - 56)) AND (b.confirmed_at < ((('now'::text)::date - w.days) - 56))))) WHERE ((b.state)::text <> ALL ((ARRAY['pending'::character varying, 'canceled'::character varying, 'waiting_confirmation'::character varying, 'deleted'::character varying])::text[])) GROUP BY (w.days / 7)), last_year AS (SELECT 'last_year'::text AS series, sum(b.value) AS sum, (w.days / 7) AS week FROM (backers b RIGHT JOIN weeks w ON ((((b.confirmed_at)::date >= (((('now'::text)::date - w.days) - 7) - 365)) AND (b.confirmed_at < ((('now'::text)::date - w.days) - 365))))) WHERE ((b.state)::text <> ALL ((ARRAY['pending'::character varying, 'canceled'::character varying, 'waiting_confirmation'::character varying, 'deleted'::character varying])::text[])) GROUP BY (w.days / 7)) (SELECT current_period.series, current_period.sum, current_period.week FROM current_period UNION ALL SELECT previous_period.series, previous_period.sum, previous_period.week FROM previous_period) UNION ALL SELECT last_year.series, last_year.sum, last_year.week FROM last_year ORDER BY 1, 3", :force => true
  create_table "channels_projects", force: true do |t|
    t.integer "channel_id"
    t.integer "project_id"
    t.index ["channel_id", "project_id"], :name => "index_channels_projects_on_channel_id_and_project_id", :unique => true, :order => {"channel_id" => :asc, "project_id" => :asc}
    t.index ["project_id"], :name => "index_channels_projects_on_project_id", :order => {"project_id" => :asc}
    t.foreign_key ["channel_id"], "channels", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channels_projects_channel_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channels_projects_project_id"
  end

  create_table "channels_subscribers", force: true do |t|
    t.integer "user_id",    null: false
    t.integer "channel_id", null: false
    t.index ["channel_id"], :name => "fk__channels_subscribers_channel_id", :order => {"channel_id" => :asc}
    t.index ["user_id"], :name => "fk__channels_subscribers_user_id", :order => {"user_id" => :asc}
    t.index ["user_id", "channel_id"], :name => "index_channels_subscribers_on_user_id_and_channel_id", :unique => true, :order => {"user_id" => :asc, "channel_id" => :asc}
    t.foreign_key ["channel_id"], "channels", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channels_subscribers_channel_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channels_subscribers_user_id"
  end

  create_view "financial_reports", "SELECT p.name, u.moip_login, p.goal, expires_at(p.*) AS expires_at, p.state FROM (projects p JOIN users u ON ((u.id = p.user_id)))", :force => true
  create_table "updates", force: true do |t|
    t.integer  "user_id",                      null: false
    t.integer  "project_id",                   null: false
    t.text     "title"
    t.text     "comment",                      null: false
    t.text     "comment_html",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "exclusive",    default: false
    t.index ["project_id"], :name => "index_updates_on_project_id", :order => {"project_id" => :asc}
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "updates_project_id_fk"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "updates_user_id_fk"
  end

  create_table "notifications", force: true do |t|
    t.integer  "user_id",                       null: false
    t.integer  "project_id"
    t.boolean  "dismissed",     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "backer_id"
    t.integer  "update_id"
    t.text     "origin_email",                  null: false
    t.text     "origin_name",                   null: false
    t.text     "template_name",                 null: false
    t.text     "locale",                        null: false
    t.integer  "channel_id"
    t.index ["channel_id"], :name => "fk__notifications_channel_id", :order => {"channel_id" => :asc}
    t.index ["update_id"], :name => "index_notifications_on_update_id", :order => {"update_id" => :asc}
    t.foreign_key ["backer_id"], "backers", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "notifications_backer_id_fk"
    t.foreign_key ["channel_id"], "channels", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_notifications_channel_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "notifications_project_id_reference"
    t.foreign_key ["update_id"], "updates", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "notifications_update_id_fk"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "notifications_user_id_reference"
  end

  create_table "payment_notifications", force: true do |t|
    t.integer  "backer_id",  null: false
    t.text     "extra_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["backer_id"], :name => "index_payment_notifications_on_backer_id", :order => {"backer_id" => :asc}
    t.foreign_key ["backer_id"], "backers", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "payment_notifications_backer_id_fk"
  end

  create_table "paypal_payments", id: false, force: true do |t|
    t.text "data"
    t.text "hora"
    t.text "fusohorario"
    t.text "nome"
    t.text "tipo"
    t.text "status"
    t.text "moeda"
    t.text "valorbruto"
    t.text "tarifa"
    t.text "liquido"
    t.text "doe_mail"
    t.text "parae_mail"
    t.text "iddatransacao"
    t.text "statusdoequivalente"
    t.text "statusdoendereco"
    t.text "titulodoitem"
    t.text "iddoitem"
    t.text "valordoenvioemanuseio"
    t.text "valordoseguro"
    t.text "impostosobrevendas"
    t.text "opcao1nome"
    t.text "opcao1valor"
    t.text "opcao2nome"
    t.text "opcao2valor"
    t.text "sitedoleilao"
    t.text "iddocomprador"
    t.text "urldoitem"
    t.text "datadetermino"
    t.text "iddaescritura"
    t.text "iddafatura"
    t.text "idtxn_dereferência"
    t.text "numerodafatura"
    t.text "numeropersonalizado"
    t.text "iddorecibo"
    t.text "saldo"
    t.text "enderecolinha1"
    t.text "enderecolinha2_distrito_bairro"
    t.text "cidade"
    t.text "estado_regiao_território_prefeitura_republica"
    t.text "cep"
    t.text "pais"
    t.text "numerodotelefoneparacontato"
    t.text "extra"
  end

  create_view "project_totals", "SELECT backers.project_id, sum(backers.value) AS pledged, ((sum(backers.value) / projects.goal) * (100)::numeric) AS progress, sum(backers.payment_service_fee) AS total_payment_service_fee, count(*) AS total_backers FROM (backers JOIN projects ON ((backers.project_id = projects.id))) WHERE ((backers.state)::text = ANY ((ARRAY['confirmed'::character varying, 'refunded'::character varying, 'requested_refund'::character varying])::text[])) GROUP BY backers.project_id, projects.goal", :force => true
  create_view "project_financials", "WITH catarse_fee_percentage AS (SELECT (c.value)::numeric AS total, ((1)::numeric - (c.value)::numeric) AS complement FROM configurations c WHERE (c.name = 'catarse_fee'::text)), catarse_base_url AS (SELECT c.value FROM configurations c WHERE (c.name = 'base_url'::text)) SELECT p.id AS project_id, p.name, u.moip_login AS moip, p.goal, pt.pledged AS reached, pt.total_payment_service_fee AS moip_tax, (cp.total * pt.pledged) AS catarse_fee, (pt.pledged * cp.complement) AS repass_value, to_char(expires_at(p.*), 'dd/mm/yyyy'::text) AS expires_at, ((catarse_base_url.value || '/admin/reports/backer_reports.csv?project_id='::text) || p.id) AS backer_report, p.state FROM ((((projects p JOIN users u ON ((u.id = p.user_id))) JOIN project_totals pt ON ((pt.project_id = p.id))) CROSS JOIN catarse_fee_percentage cp) CROSS JOIN catarse_base_url)", :force => true
  create_view "projects_by_periods", "WITH weeks AS (SELECT (generate_series.generate_series * 7) AS days FROM generate_series(0, 7) generate_series(generate_series)), current_period AS (SELECT 'current_period'::text AS series, count(*) AS count, (w.days / 7) AS week FROM (projects p RIGHT JOIN weeks w ON ((((p.created_at)::date >= ((('now'::text)::date - w.days) - 7)) AND (p.created_at < (('now'::text)::date - w.days))))) GROUP BY (w.days / 7)), previous_period AS (SELECT 'previous_period'::text AS series, count(*) AS count, (w.days / 7) AS week FROM (projects p RIGHT JOIN weeks w ON ((((p.created_at)::date >= (((('now'::text)::date - w.days) - 7) - 56)) AND (p.created_at < ((('now'::text)::date - w.days) - 56))))) GROUP BY (w.days / 7)), last_year AS (SELECT 'last_year'::text AS series, count(*) AS count, (w.days / 7) AS week FROM (projects p RIGHT JOIN weeks w ON ((((p.created_at)::date >= (((('now'::text)::date - w.days) - 7) - 365)) AND (p.created_at < ((('now'::text)::date - w.days) - 365))))) GROUP BY (w.days / 7)) (SELECT current_period.series, current_period.count, current_period.week FROM current_period UNION ALL SELECT previous_period.series, previous_period.count, previous_period.week FROM previous_period) UNION ALL SELECT last_year.series, last_year.count, last_year.week FROM last_year ORDER BY 1, 3", :force => true
  create_view "projects_for_home", "WITH recommended_projects AS (SELECT 'recommended'::text AS origin, recommends.id, recommends.name, recommends.user_id, recommends.category_id, recommends.goal, recommends.about, recommends.headline, recommends.video_url, recommends.short_url, recommends.created_at, recommends.updated_at, recommends.about_html, recommends.recommended, recommends.home_page_comment, recommends.permalink, recommends.video_thumbnail, recommends.state, recommends.online_days, recommends.online_date, recommends.how_know, recommends.more_links, recommends.first_backers, recommends.uploaded_image, recommends.video_embed_url FROM projects recommends WHERE (recommends.recommended AND ((recommends.state)::text = 'online'::text)) ORDER BY random() LIMIT 3), recents_projects AS (SELECT 'recents'::text AS origin, recents.id, recents.name, recents.user_id, recents.category_id, recents.goal, recents.about, recents.headline, recents.video_url, recents.short_url, recents.created_at, recents.updated_at, recents.about_html, recents.recommended, recents.home_page_comment, recents.permalink, recents.video_thumbnail, recents.state, recents.online_days, recents.online_date, recents.how_know, recents.more_links, recents.first_backers, recents.uploaded_image, recents.video_embed_url FROM projects recents WHERE ((((recents.state)::text = 'online'::text) AND ((now() - recents.online_date) <= '5 days'::interval)) AND (NOT (recents.id IN (SELECT recommends.id FROM recommended_projects recommends)))) ORDER BY random() LIMIT 3), expiring_projects AS (SELECT 'expiring'::text AS origin, expiring.id, expiring.name, expiring.user_id, expiring.category_id, expiring.goal, expiring.about, expiring.headline, expiring.video_url, expiring.short_url, expiring.created_at, expiring.updated_at, expiring.about_html, expiring.recommended, expiring.home_page_comment, expiring.permalink, expiring.video_thumbnail, expiring.state, expiring.online_days, expiring.online_date, expiring.how_know, expiring.more_links, expiring.first_backers, expiring.uploaded_image, expiring.video_embed_url FROM projects expiring WHERE ((((expiring.state)::text = 'online'::text) AND (expires_at(expiring.*) <= (now() + '14 days'::interval))) AND (NOT (expiring.id IN (SELECT recommends.id FROM recommended_projects recommends UNION SELECT recents.id FROM recents_projects recents)))) ORDER BY random() LIMIT 3) (SELECT recommended_projects.origin, recommended_projects.id, recommended_projects.name, recommended_projects.user_id, recommended_projects.category_id, recommended_projects.goal, recommended_projects.about, recommended_projects.headline, recommended_projects.video_url, recommended_projects.short_url, recommended_projects.created_at, recommended_projects.updated_at, recommended_projects.about_html, recommended_projects.recommended, recommended_projects.home_page_comment, recommended_projects.permalink, recommended_projects.video_thumbnail, recommended_projects.state, recommended_projects.online_days, recommended_projects.online_date, recommended_projects.how_know, recommended_projects.more_links, recommended_projects.first_backers, recommended_projects.uploaded_image, recommended_projects.video_embed_url FROM recommended_projects UNION SELECT recents_projects.origin, recents_projects.id, recents_projects.name, recents_projects.user_id, recents_projects.category_id, recents_projects.goal, recents_projects.about, recents_projects.headline, recents_projects.video_url, recents_projects.short_url, recents_projects.created_at, recents_projects.updated_at, recents_projects.about_html, recents_projects.recommended, recents_projects.home_page_comment, recents_projects.permalink, recents_projects.video_thumbnail, recents_projects.state, recents_projects.online_days, recents_projects.online_date, recents_projects.how_know, recents_projects.more_links, recents_projects.first_backers, recents_projects.uploaded_image, recents_projects.video_embed_url FROM recents_projects) UNION SELECT expiring_projects.origin, expiring_projects.id, expiring_projects.name, expiring_projects.user_id, expiring_projects.category_id, expiring_projects.goal, expiring_projects.about, expiring_projects.headline, expiring_projects.video_url, expiring_projects.short_url, expiring_projects.created_at, expiring_projects.updated_at, expiring_projects.about_html, expiring_projects.recommended, expiring_projects.home_page_comment, expiring_projects.permalink, expiring_projects.video_thumbnail, expiring_projects.state, expiring_projects.online_days, expiring_projects.online_date, expiring_projects.how_know, expiring_projects.more_links, expiring_projects.first_backers, expiring_projects.uploaded_image, expiring_projects.video_embed_url FROM expiring_projects", :force => true
  create_view "recommendations", "SELECT recommendations.user_id, recommendations.project_id, (sum(recommendations.count))::bigint AS count FROM (SELECT b.user_id, recommendations.id AS project_id, count(DISTINCT recommenders.user_id) AS count FROM ((((backers b JOIN projects p ON ((p.id = b.project_id))) JOIN backers backers_same_projects ON ((p.id = backers_same_projects.project_id))) JOIN backers recommenders ON ((recommenders.user_id = backers_same_projects.user_id))) JOIN projects recommendations ON ((recommendations.id = recommenders.project_id))) WHERE ((((((((b.state)::text = 'confirmed'::text) AND ((backers_same_projects.state)::text = 'confirmed'::text)) AND ((recommenders.state)::text = 'confirmed'::text)) AND (b.user_id <> backers_same_projects.user_id)) AND (recommendations.id <> b.project_id)) AND ((recommendations.state)::text = 'online'::text)) AND (NOT (EXISTS (SELECT true AS bool FROM backers b2 WHERE ((((b2.state)::text = 'confirmed'::text) AND (b2.user_id = b.user_id)) AND (b2.project_id = recommendations.id)))))) GROUP BY b.user_id, recommendations.id UNION SELECT b.user_id, recommendations.id AS project_id, 0 AS count FROM ((backers b JOIN projects p ON ((b.project_id = p.id))) JOIN projects recommendations ON ((recommendations.category_id = p.category_id))) WHERE (((b.state)::text = 'confirmed'::text) AND ((recommendations.state)::text = 'online'::text))) recommendations WHERE (NOT (EXISTS (SELECT true AS bool FROM backers b2 WHERE ((((b2.state)::text = 'confirmed'::text) AND (b2.user_id = recommendations.user_id)) AND (b2.project_id = recommendations.project_id))))) GROUP BY recommendations.user_id, recommendations.project_id ORDER BY (sum(recommendations.count))::bigint DESC", :force => true
  create_table "states", force: true do |t|
    t.string   "name",       null: false
    t.string   "acronym",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["acronym"], :name => "states_acronym_unique", :unique => true, :order => {"acronym" => :asc}
    t.index ["name"], :name => "states_name_unique", :unique => true, :order => {"name" => :asc}
  end

  create_view "statistics", "SELECT (SELECT count(*) AS count FROM users) AS total_users, backers_totals.total_backs, backers_totals.total_backers, backers_totals.total_backed, projects_totals.total_projects, projects_totals.total_projects_success, projects_totals.total_projects_online FROM (SELECT count(*) AS total_backs, count(DISTINCT backers.user_id) AS total_backers, sum(backers.value) AS total_backed FROM backers WHERE ((backers.state)::text <> ALL (ARRAY[('waiting_confirmation'::character varying)::text, ('pending'::character varying)::text, ('canceled'::character varying)::text, 'deleted'::text]))) backers_totals, (SELECT count(*) AS total_projects, count(CASE WHEN ((projects.state)::text = 'successful'::text) THEN 1 ELSE NULL::integer END) AS total_projects_success, count(CASE WHEN ((projects.state)::text = 'online'::text) THEN 1 ELSE NULL::integer END) AS total_projects_online FROM projects WHERE ((projects.state)::text <> ALL (ARRAY[('draft'::character varying)::text, ('rejected'::character varying)::text]))) projects_totals", :force => true
  create_view "subscriber_reports", "SELECT u.id, cs.channel_id, u.name, u.email FROM (users u JOIN channels_subscribers cs ON ((cs.user_id = u.id)))", :force => true
  create_table "total_backed_ranges", id: false, force: true do |t|
    t.text    "name",  null: false
    t.decimal "lower"
    t.decimal "upper"
  end

  create_table "unsubscribes", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], :name => "index_unsubscribes_on_project_id", :order => {"project_id" => :asc}
    t.index ["user_id"], :name => "index_unsubscribes_on_user_id", :order => {"user_id" => :asc}
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "unsubscribes_project_id_fk"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "unsubscribes_user_id_fk"
  end

  create_view "user_totals", "SELECT b.user_id AS id, b.user_id, count(DISTINCT b.project_id) AS total_backed_projects, sum(b.value) AS sum, count(*) AS count, sum(CASE WHEN (((p.state)::text <> 'failed'::text) AND (NOT b.credits)) THEN (0)::numeric WHEN (((p.state)::text = 'failed'::text) AND b.credits) THEN (0)::numeric WHEN (((p.state)::text = 'failed'::text) AND ((((b.state)::text = ANY ((ARRAY['requested_refund'::character varying, 'refunded'::character varying])::text[])) AND (NOT b.credits)) OR (b.credits AND (NOT ((b.state)::text = ANY ((ARRAY['requested_refund'::character varying, 'refunded'::character varying])::text[])))))) THEN (0)::numeric WHEN ((((p.state)::text = 'failed'::text) AND (NOT b.credits)) AND ((b.state)::text = 'confirmed'::text)) THEN b.value ELSE (b.value * ((-1))::numeric) END) AS credits FROM (backers b JOIN projects p ON ((b.project_id = p.id))) WHERE ((b.state)::text = ANY ((ARRAY['confirmed'::character varying, 'requested_refund'::character varying, 'refunded'::character varying])::text[])) GROUP BY b.user_id", :force => true
  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id", :order => {"item_type" => :asc, "item_id" => :asc}
  end

end
