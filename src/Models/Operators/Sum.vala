/* Sum.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Math;
public class DescriptiveStatistics.Sum : Operator {
    public override string name {
        get {
            return "Sum";
        }
    }

    public Sum (SharedData shared_data, Column column) {
        Object (
            shared_data: shared_data,
            column: column
        );
    }

    public override double calculate () {
        double sum = 0;
        foreach (double value in collect_values ()) {
            sum+= value;
        }

        shared_data.sum = sum;
        return sum;
    }
}
