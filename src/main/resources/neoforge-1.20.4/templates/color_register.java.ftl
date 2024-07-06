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

        <#if w.getGElementsOfType("dyeable_item")?filter(e -> e.dyeableItem.canWaterRemoveColor())?size != 0>
        Map<Item, CauldronInteraction> WATER_MAP = CauldronInteraction.WATER.map();
        CauldronInteraction.addDefaultInteractions(WATER_MAP);
        </#if>
        <#if w.getGElementsOfType("dyeable_item")?filter(e -> e.dyeableItem.canLavaRemoveColor())?size != 0>
        Map<Item, CauldronInteraction> LAVA_MAP = CauldronInteraction.LAVA.map();
        CauldronInteraction.addDefaultInteractions(LAVA_MAP);
        </#if>
        <#if w.getGElementsOfType("dyeable_item")?filter(e -> e.dyeableItem.canPowderSnowRemoveColor())?size != 0>
        Map<Item, CauldronInteraction> POWDER_SNOW_MAP = CauldronInteraction.POWDER_SNOW.map();
        CauldronInteraction.addDefaultInteractions(POWDER_SNOW_MAP);
        </#if>

        <#list w.getGElementsOfType("dyeable_item")?filter(e -> e.dyeableItem.isDyeable()) as e>
        <#if e.dyeableItem.canWaterRemoveColor()>
        WATER_MAP.put(${JavaModName}Items.${e.getModElement().getRegistryNameUpper()}.get(), INTERACTION);
        </#if>
        <#if e.dyeableItem.canLavaRemoveColor()>
        LAVA_MAP.put(${JavaModName}Items.${e.getModElement().getRegistryNameUpper()}.get(), INTERACTION);
        </#if>
        <#if e.dyeableItem.canPowderSnowRemoveColor()>
        POWDER_SNOW_MAP.put(${JavaModName}Items.${e.getModElement().getRegistryNameUpper()}.get(), INTERACTION);
        </#if>
        </#list>
    }
}