module RumoText
#
# https://developer.apple.com/library/mac/documentation/Carbon/reference/CTParagraphStyleRef/Reference/reference.html#//apple_ref/doc/uid/TP40005114
# CTParagraphStyleSpecifier
# alignment attribute should have CTTextAlignment instance.
# alignment = CTTextAlignment.left|CTTextAlignment.right|...
#
  class ParagraphStyle
    KEY_FIELD_MAP = {
      KCTParagraphStyleSpecifierAlignment => '@alignment',
      KCTParagraphStyleSpecifierFirstLineHeadIndent => '@first_line_head_indent',
      KCTParagraphStyleSpecifierHeadIndent => '@head_indent',
      KCTParagraphStyleSpecifierTailIndent => '@tail_indent',
      KCTParagraphStyleSpecifierTabStops => '@tab_stops',
      KCTParagraphStyleSpecifierDefaultTabInterval => '@default_tab_interval',
      KCTParagraphStyleSpecifierLineBreakMode => '@line_break_mode',
      KCTParagraphStyleSpecifierLineHeightMultiple => '@line_height_multiple',
      KCTParagraphStyleSpecifierMaximumLineHeight => '@maximum_line_height',
      KCTParagraphStyleSpecifierMinimumLineHeight => '@minimum_line_height',
#     KCTParagraphStyleSpecifierLineSpacing => '@line_spacing', # deprecated
      KCTParagraphStyleSpecifierParagraphSpacing => '@paragraph_spacing',
      KCTParagraphStyleSpecifierParagraphSpacingBefore => '@paragraph_spacing_before',
      KCTParagraphStyleSpecifierBaseWritingDirection => '@base_writing_direction',
      KCTParagraphStyleSpecifierMaximumLineSpacing => '@maximum_line_spacing',
      KCTParagraphStyleSpecifierMinimumLineSpacing => '@minimum_line_spacing',
      KCTParagraphStyleSpecifierLineSpacingAdjustment => '@line_spacing_adjustment',
    }

    attr_accessor :alignment, :first_line_head_indent, :head_indent, :tail_indent
    attr_accessor :tab_stops, :default_tab_interval, :line_break_mode, :line_height_multiple
    attr_accessor :maximum_line_height, :minimum_line_height
    attr_accessor :paragraph_spacing, :paragraph_spacing_before, :base_writing_direction
    attr_accessor :maximum_line_spacing, :minimum_line_spacing, :line_spacing_adjustment

    def create_ct_paragraph_style
      settings = create_settings
      if settings.size > 0
        settings_ptr = Pointer.new(CTParagraphStyleSetting.type, settings.size)
        settings.each_with_index do |setting, i|
          settings_ptr[i] = setting
        end
        CTParagraphStyleCreate(settings_ptr, settings.size)
      else
        nil
      end
    end

    def create_settings
      settings = []
      KEY_FIELD_MAP.each do |key, instance_variable_name|
        type_helper = nil
        value = instance_variable_get(instance_variable_name)
        next unless value

        case key
        when KCTParagraphStyleSpecifierAlignment
          type_helper = value.is_a?(CTTextAlignment) ? value : nil
        when KCTParagraphStyleSpecifierFirstLineHeadIndent,
          KCTParagraphStyleSpecifierHeadIndent,
          KCTParagraphStyleSpecifierTailIndent,
          KCTParagraphStyleSpecifierDefaultTabInterval,
          KCTParagraphStyleSpecifierLineHeightMultiple,
          KCTParagraphStyleSpecifierParagraphSpacing,
          KCTParagraphStyleSpecifierParagraphSpacingBefore,
          KCTParagraphStyleSpecifierMaximumLineHeight,
          KCTParagraphStyleSpecifierMinimumLineHeight,
          KCTParagraphStyleSpecifierMinimumLineSpacing,
          KCTParagraphStyleSpecifierMaximumLineSpacing,
          KCTParagraphStyleSpecifierLineSpacingAdjustment
          type_helper = TypeFloat.new(value)
        when KCTParagraphStyleSpecifierTabStops
          type_helper = handle_tab_stops(value)
        when KCTParagraphStyleSpecifierLineBreakMode
          type_helper = value.is_a?(CTLineBreakMode) ? value : nil
        when KCTParagraphStyleSpecifierBaseWritingDirection
          type_helper = value.is_a?(CTWritingDirection) ? value : nil
        else
          p "Ignore unknown parameter: #{key}, #{value}"
        end

        if type_helper
          settings << CTParagraphStyleSetting.new(key, type_helper.size, type_helper.pointer)
        end
      end
      settings
    end

    def add_tab_stop(tab_stop)
      @tab_stops ||= []
      @tab_stops << tab_stop
    end

    def remove_tab_stop(tab_stop)
      @tab_stops.delete tab_stop if @tab_stops
    end

    private

    def handle_tab_stops(tab_stops_value)
      tab_array = nil
      if tab_stops_value.is_a?(CTTextTab)
        tab_array = [tab_stops_value.value]
      elsif tab_stops_value.is_a?(Array)
        tab_array = tab_stops_value.dup
        tab_array.map! do |text_tab|
          text_tab.is_a?(CTTextTab) ? text_tab.value : text_tab
        end
      end
      tab_array.nil? ? nil : TypeObject.new(tab_array)
    end
  end
end
