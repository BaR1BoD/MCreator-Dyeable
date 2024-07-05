package ${package}.client.color;

public class RegisterColor {
    @SubscribeEvent public static void onItemColorRegister(RegisterColorHandlersEvent.Item event) {
        event.register((stack, tintIndex) -> tintIndex > 0 ? -1 : ((IDyeableItem) stack.getItem()).getColor(stack)<#list w.getGElementsOfType("dyeable_item")?filter(e -> e.dyeableItem.isDyeable()) as e>, ${JavaModName}Items.${e.getModElement().getRegistryNameUpper()}.get()</#list>);

        <#if w.getGElementsOfType("dyeable_item")?filter(e -> e.dyeableItem.isDyeable() && e.canRemoveColor())?size != 0>
        CauldronInteraction INTERACTION = (state, level, pos, player, hand, stack) -> {
            Item item = stack.getItem();

            if (!(item instanceof IDyeableItem dyeableItem))
                return InteractionResult.PASS;
            else if (!dyeableItem.hasColor(stack))
                return InteractionResult.PASS;
            else {
                if (!level.isClientSide) {
                    dyeableItem.removeColor(stack);
                    LayeredCauldronBlock.lowerFillLevel(state, level, pos);
                }
                return InteractionResult.sidedSuccess(level.isClientSide);
            }
        };
        </#if>

        <#list w.getGElementsOfType("dyeable_item")?filter(e -> e.dyeableItem.isDyeable()) as e>
        <#if e.dyeableItem.canWaterRemoveColor()>
        CauldronInteraction.WATER.put(${JavaModName}Items.${e.getModElement().getRegistryNameUpper()}.get(), INTERACTION);
        </#if>
        <#if e.dyeableItem.canLavaRemoveColor()>
        CauldronInteraction.LAVA.put(${JavaModName}Items.${e.getModElement().getRegistryNameUpper()}.get(), INTERACTION);
        </#if>
        <#if e.dyeableItem.canPowderSnowRemoveColor()>
        CauldronInteraction.POWDER_SNOW.put(${JavaModName}Items.${e.getModElement().getRegistryNameUpper()}.get(), INTERACTION);
        </#if>
        </#list>
    }
}