package me.barbod.dyeable.element.parts;

import javax.annotation.Nullable;
import java.awt.*;

public record DyeableItemProperties(@Nullable Part part, String overlayTexture, boolean isDyeable, Color defaultColor,
                                    boolean canWaterRemoveColor, boolean canLavaRemoveColor, boolean canPowderSnowRemoveColor) {

    public DyeableItemProperties(String overlayTexture, boolean isDyeable, Color defaultColor, boolean canWaterRemoveColor, boolean canLavaRemoveColor,
                                 boolean canPowderSnowRemoveColor) {
        this(null, overlayTexture, isDyeable, defaultColor, canWaterRemoveColor, canLavaRemoveColor, canPowderSnowRemoveColor);
    }

    public boolean hasOverlayTexture() {
        return !overlayTexture.isEmpty();
    }

    public boolean canRemoveColor() {
        return canWaterRemoveColor || canLavaRemoveColor || canPowderSnowRemoveColor;
    }

    public enum Part {
        HELMET,
        BODY,
        LEGGINGS,
        BOOTS
    }
}
