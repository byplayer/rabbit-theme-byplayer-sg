add_image_path("clear-blue-images")

base_color = "#458cff"
base_dark_color = "#0041ab"
base_dark_background_color = "#e9ffff"
base_background_color = "#ffffff"

set_graffiti_color("#{base_color}99")
set_graffiti_line_width(30)

set_progress_foreground(base_color)
set_progress_background(base_background_color)

@default_item1_mark_color = base_color
@default_item1_mark_type = "check"
@default_item2_mark_color = base_color
@default_item2_mark_type = "check"
@default_item3_mark_color = base_color
@default_item3_mark_type = "check"
@default_enum_item1_mark_color = base_color
@default_enum_item1_mark_type = "check"
@default_enum_item2_mark_color = base_color
@default_enum_item2_mark_type = "check"
@default_description_item1_mark_color = base_color
@default_block_quote_item1_mark_color = base_color
@description_term_line_color = base_color
@default_headline_line_color = "#000000"

@default_emphasis_color = base_dark_color

@preformatted_frame_color = base_color
@preformatted_fill_color = base_background_color

@block_quote_frame_color = base_color
@block_quote_fill_color = base_background_color

@table_frame_color = base_color
@table_fill_color = base_background_color
@table_body_frame_color = base_color
@table_body_fill_color = base_background_color
@table_head_frame_color = base_color
@table_head_fill_color = base_dark_background_color

add_image_path("rabbit-images")

@block_quote_open_quote_image = "open-quote-blue.png"
@block_quote_close_quote_image = "close-quote-blue.png"

@block_quote_frame_width = 0
@block_quote_fill_color = "#fff0"
@block_quote_padding_left = 0
@block_quote_padding_right = 0
@block_quote_padding_top = 0
@block_quote_padding_bottom = 0
@block_quote_image_background_alpha = 0.3
@block_quote_image_frame = true

@margin_bottom = canvas.height * 0.05

include_theme("default")

match("**", Paragraph) do |texts|
  texts.margin_top = @space / 10.0
  texts.margin_bottom = @space / 10.0
end

match(TitleSlide, "*") do |elements|
  elements.horizontal_centering = false
  elements.align = :center
end

match(TitleSlide, Title) do |titles|
  titles.padding_bottom = @space * 2
end

match(Slide, HeadLine) do |heads|
  # name = "head-line"
  # heads.delete_post_draw_proc_by_name(name)

  heads.horizontal_centering = true
  heads.prop_set("weight", "normal")
  prop_set("size", @small_font_size)
end

match(Slide, Body) do |bodies|
  bodies.vertical_centering = true
  bodies.each do |body|
    next if body.elements.all? {|element| element.is_a?(Image)}
    next if body.elements.any? {|element| element.is_a?(BlockQuote)}
    next if body.elements.any? {|element| element.is_a?(PreformattedBlock)}
    next if body.elements.any? {|element| element.is_a?(Table)}
    body.margin_left = canvas.width * 0.05
    body.margin_right = canvas.width * 0.05
  end
end

match("**", BlockQuote) do |quotes|
  quotes.each do |quote|
    first_element = quote.elements.first
    next unless first_element.is_a?(Paragraph)
    first_element.indent = first_element.prop_get("size")
  end
end

@slide_logo_image ||= "clear-blue-headline-background.png"
include_theme("slide-logo")

@icon_images = ["clear-blue-icon.png"]
include_theme("icon")

@slide_footer_info_left_text ||= canvas.title.gsub(/\n/, '')
@slide_footer_info_right_text ||= "Powered by Rabbit #{Rabbit::VERSION}"
include_theme("slide-footer-info")
