{if $staff}

    {if !$no_pagination}
        {include file="common/pagination.tpl"}
    {/if}
    <div class="grid-list">
        {foreach from=$staff item="person"}
            {if $person.status == 'A'}
                <div class="ty-column3">
                    <a href="index.php?dispatch=staff.view&person_id={$person.person_id}">        
                        <div class="ty-grid-list__item ty-quick-view-button__wrapper ty-grid-list__item--overlay">
                            <div class="ty-grid-list__image">
                                {include 
                                    file="common/image.tpl" 
                                    images=$person.image 
                                    class="ty-pict cm-image"
                                    image_width=300
                                    image_height=300
                                }
                            </div>
                            <div class="ty-grid-list__item-name">
                                <h3>{$person.name}</h3>
                            </div>
                            <div class="ty-grid-list__price">
                                <span>{$person.post}</span>
                            </div>
                        </div>
                    </a>
                </div>
            {/if}
        {/foreach}
    </div>
    {if !$no_pagination}
        {include file="common/pagination.tpl"}
    {/if}
{/if}
{capture name="mainbox_title"}{__("staff")}{/capture}