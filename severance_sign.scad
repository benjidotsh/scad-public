top_text = "MACRODATA";
bottom_text = "REFINEMENT";
font_name = "Michroma";
font_size = 12;
line_thickness = 2;
text_spacing = 6;
margin_x = 8;
margin_y = 8;
layer_height = 2;
text_thickness = 0.5;

module render() {
    top_text_metrics = textmetrics(text=top_text, font=font_name, size=font_size, valign="top");
    bottom_text_metrics = textmetrics(text=bottom_text, font=font_name, size=font_size);

    top_text_width = top_text_metrics.size.x;
    top_text_height = top_text_metrics.size.y;
    bottom_text_width = bottom_text_metrics.size.x;  
    bottom_text_height = bottom_text_metrics.size.y;

    text_width = max(top_text_width, bottom_text_width);
    text_height = top_text_height + text_spacing + bottom_text_height;

    // base
    base_width = margin_x + line_thickness + margin_x + text_width + margin_x;
    base_height = margin_y + text_height + margin_y;
    color("white")
    cube([base_width, base_height, layer_height]);

    // line
    line_x = margin_x;
    line_y = margin_y;
    line_height = text_height;
    translate([line_x, line_y, layer_height]) {
        color("black")
        cube([line_thickness, line_height, layer_height]);
    }
    
    text_start_x = margin_x + line_thickness + margin_x;
    text_start_y = margin_y;

    // top text
    top_text_x = text_start_x;
    top_text_y_offset = 0.025 * font_size;
    top_text_y = text_start_y + text_height - text_thickness + top_text_y_offset;
    translate([top_text_x, top_text_y, layer_height]) {
        color("black")
        linear_extrude(height=layer_height)
        offset(delta=text_thickness)
        text(top_text, font=font_name, size=font_size, valign="top");
    }
    
    // bottom text
    bottom_text_x = text_start_x;
    bottom_text_y = text_start_y + text_thickness;
    translate([bottom_text_x, bottom_text_y, layer_height]) {
        color("black")
        linear_extrude(height=layer_height)
        offset(delta=text_thickness)
        text(bottom_text, font=font_name, size=font_size);
    }
}

render();