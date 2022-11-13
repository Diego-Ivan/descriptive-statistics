/* VisualizationGrid.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class DescriptiveStatistics.VisualizationGrid : Gtk.Grid {
    public VisualizationGrid () {
    }

    construct {
        hexpand = true;
        vexpand = true;
        column_homogeneous = true;
    }

    public void populate (ListModel model) requires (model.get_item_type () == typeof (Column)){
        for (int i = 0; i < model.get_n_items (); i++) {
            var item = (Column) model.get_item (i);

            for (int j = 0; j < item.get_n_items (); j++) {
                var row = (Row) item.get_item (j);
                var label = new Gtk.Label (row.content);

                attach (label, i, j);
            }
        }
    }
}
