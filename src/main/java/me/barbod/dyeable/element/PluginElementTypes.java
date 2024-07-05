package me.barbod.dyeable.element;

import me.barbod.dyeable.element.types.DyeableItem;
import me.barbod.dyeable.ui.modgui.DyeableItemGUI;
import net.mcreator.element.ModElementType;
import net.mcreator.element.ModElementTypeLoader;

public class PluginElementTypes {
    public static ModElementType<?> DYEABLE_ITEM;

    public static void load() {
        DYEABLE_ITEM = ModElementTypeLoader.register(new ModElementType<>("dyeable_item", null, DyeableItemGUI::new, DyeableItem.class));
    }
}
