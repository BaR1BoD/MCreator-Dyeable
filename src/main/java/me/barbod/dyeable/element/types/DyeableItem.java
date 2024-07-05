package me.barbod.dyeable.element.types;

import me.barbod.dyeable.element.parts.DyeableItemProperties;
import net.mcreator.element.types.Item;
import net.mcreator.ui.workspace.resources.TextureType;
import net.mcreator.util.image.ImageUtils;
import net.mcreator.workspace.elements.ModElement;

import java.awt.*;
import java.awt.image.BufferedImage;

@SuppressWarnings("unused")
public class DyeableItem extends Item {
    public DyeableItemProperties dyeableItem;

    public DyeableItem(ModElement element) {
        super(element);
    }

    public boolean canRemoveColor() {
        return dyeableItem.canRemoveColor();
    }

    @Override
    public BufferedImage generateModElementPicture() {
        BufferedImage image = super.generateModElementPicture();

        BufferedImage image$res = new BufferedImage(image.getWidth(), image.getHeight(), BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2d = image$res.createGraphics();

        g2d.drawImage(image, 0, 0, null);

        if (dyeableItem.isDyeable()) {
            g2d.setColor(dyeableItem.defaultColor());
            g2d.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, 0.5f));
            g2d.fillRect(0, 0, image.getWidth(), image.getHeight());
        }

        if (dyeableItem.hasOverlayTexture()) {
            BufferedImage overlay = ImageUtils.resizeAndCrop(
                    getModElement().getFolderManager().getTextureImageIcon(dyeableItem.overlayTexture(), TextureType.ITEM).getImage(), 32);

            g2d.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER));
            g2d.drawImage(overlay, 0, 0, null);
        }

        g2d.dispose();

        return image$res;
    }
}
