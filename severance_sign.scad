/* [Text] */
text_top = "MACRODATA";
text_bottom = "REFINEMENT";
text_spacing = 4;
text_offset = 4;

/* [Font] */
font_name = "Michroma";
font_size = 10;
font_thickness = 0.25;

/* [Line] */
line_thickness = 2;

/* [Margin] */
margin_x = 6;
margin_y = 6;

/* [Other] */
layer_height = 2;

/* [Hidden] */
debug = false;

text_top_metrics = textmetrics(text=text_top, font=font_name, size=font_size, valign="top");
text_bottom_metrics = textmetrics(text=text_bottom, font=font_name, size=font_size);

text_top_width = text_top_metrics.size.x;
text_top_height = text_top_metrics.size.y;
text_bottom_width = text_bottom_metrics.size.x;  
text_bottom_height = text_bottom_metrics.size.y;

text_width = max(text_top_width, text_bottom_width);
text_height = text_top_height + text_spacing + text_bottom_height;

module renderBase() {
    base_width = margin_x + line_thickness + text_offset + text_width + margin_x;
    base_height = margin_y + text_height + margin_y;
    color("white")
    cube([base_width, base_height, layer_height]);
}

module renderLine() {
    line_x = margin_x;
    line_y = margin_y;
    line_height = text_height;
    translate([line_x, line_y, layer_height]) {
        color("black")
        cube([line_thickness, line_height, layer_height]);

        if (debug) #cube([line_thickness, line_height, layer_height]);
    }
}

module renderText() {
    text_start_x = margin_x + line_thickness + text_offset;
    text_start_y = margin_y;
    text_tolerance = -1;

    // top
    text_top_x = text_start_x;
    text_top_y = text_start_y + text_height - font_thickness;
    translate([text_top_x, text_top_y, layer_height]) {
        translate([text_tolerance, 0, 0]) {
            color("black")
            linear_extrude(height=layer_height)
            offset(delta=font_thickness)
            text(text_top, font=font_name, size=font_size, valign="top");
        }

        if (debug) translate([0, -text_top_height, 0]) {
            #cube([text_top_width, text_top_height, layer_height]);
        }
    }
    
    // bottom
    text_bottom_x = text_start_x;
    text_bottom_y = text_start_y + font_thickness;
    translate([text_bottom_x, text_bottom_y, layer_height]) {
        translate([-1, 0, 0]) {
            color("black")
            linear_extrude(height=layer_height)
            offset(delta=font_thickness)
            text(text_bottom, font=font_name, size=font_size);
        }

        if (debug) #cube([text_bottom_width, text_bottom_height, layer_height]);
    }
}

renderBase();
renderLine();
renderText();