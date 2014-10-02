class Image < ActiveRecord::Base

  # named_scope :masters, :conditions => { :parent_id => nil, :owner_id => nil }
  named_scope :this_user, lambda { |user| { :conditions => ["user_id = ?", user.id] } }

  # has_many :images, :foreign_key => "owner_id"
  has_one :request, :class_name => "Request", :foreign_key => "image_id"
  has_one :owner_request, :class_name => "Request", :foreign_key => "updated_image_id"

  belongs_to :description
  belongs_to :image
  belongs_to :user
  belongs_to :image_shell

  has_one :original , :class_name => "ImageShell", :foreign_key => "original_id"
  has_one :editorial, :class_name => "ImageShell", :foreign_key => "editorial_id"
  has_one :stock    , :class_name => "ImageShell", :foreign_key => "stock_id"


  # :medium => { :geometry => "300x300>" , :processors => [:thumbnail,:watermark] }}
  # has_attached_file :file, 
  #     :styles => { 
  #         :medium => { :geometry => "300x300>" , :processors => [:thumbnail,:watermark] }}
  # has_attached_file :file, 
  #     :styles => { 
  #         :medium => { :geometry => "300x300>"}
  #         :thumb =>  { :geometry => "100x100#"}
  #     }:processors => [:thumbnail,:watermark] }
  has_attached_file :image,
    :processors => [:thumbnail, :watermark],
    :styles => {
      :large => {
        :geometry => "1000x1000>",
        :watermark_path => "#{RAILS_ROOT}/public/images/watermark.png",
        :position => "South" 
        },
      :medium => {
        :geometry => "400x400>",
        :watermark_path => "#{RAILS_ROOT}/public/images/watermark.png",
        :position => "South" 
        },  
      :thumb => {
        :geometry => "150x150>"
        }
      },
    :url  => "/i/:id/:style/:basename.:extension",
    :path => ":rails_root/public/i/:id/:style/:basename.:extension"
      
  # has_attached_file :image, :styles => { :large => ["1000x1000>",:jpg], :medium => ["400x400>",:jpg], :thumb => ["150x150>",:jpg],
  #   :watermark_path => "#{RAILS_ROOT}/public/images/watermark.png",
  #   #    :position => "Center"
  #    },
  #   :processors => [:thumbnail,:watermark], 
  #   :url  => "/assets/images/:id/:style/:basename.:extension",
  #   :path => ":rails_root/public/assets/images/:id/:style/:basename.:extension"

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 100.megabytes
  validates_attachment_content_type :image, :content_type => [
      'image/jpeg',
      'image/pjpeg',
      'image/jpg',
      'image/gif',
      'image/png',
      'image/tiff',
      'image/x-png',
      'image/jpg',
      'image/x-ms-bmp',
      'image/bmp',
      'image/x-bmp',
      'image/x-bitmap',
      'image/x-xbitmap',
      'image/x-win-bitmap',
      'image/x-windows-bmp',
      'image/ms-bmp',
      'application/preview',
      'image/jp_',
      'application/jpg',
      'application/x-jpg',
      'image/pipeg',
      'application/x-png',
      'image/gi_',
      'application/octet-stream'
  ]
  
end