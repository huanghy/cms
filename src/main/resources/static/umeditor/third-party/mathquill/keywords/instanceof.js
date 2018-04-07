boolean or toggle choices. Note that you can
            specify the <code class="literal">required</code> attribute on the <code class="literal">Property</code>
            annotation, but it will not be evaluated because that would leave the user without a
            choice whether to check the box or not. The value stored in the diagram is
            java.lang.Boolean.toString(boolean), which results in "true" or "false".</p><p>
            </p><div class="mediaobject" align="center"><img src="images/designer.property.boolean.choice.png" align="middle"></div><p>
          </p></div><div class="section" title="PropertyType.RADIO_CHOICE"><div class="titlepage"><div><div><h5 class="title"><a name="N12707"></a>PropertyType.RADIO_CHOICE</h5></div></div></div><p>Creates a group of radio buttons as shown below. Selection of any of the radio
            buttons is mutually exclusive with selection of any of the others (i.e., only one
            selection allowed). Can be a required field and shows validation messages as a tooltip.
            Validation failures are displayed by changing the background of the group to a light red
            color.</p><p>This property type expects the class member you have a