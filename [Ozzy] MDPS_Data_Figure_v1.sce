clc
clear

// IMPORT DATA FILES //
filePath = "C:\Ozzys\03. Documents\03.01. Documents related to work\A2234_RME_A2Z MDPS\Report\Trace Data\Converted CSV type"
importFilename ="221028_auto_200.csv" 

filename = fullfile(filePath, importFilename) 
dataFrame = read_csv(filename)

cnt1 = 1
cnt2 = 1
cnt3 = 1

for i = 2:33578
    if dataFrame(i, 4) == "028A" then
        dF_28A(cnt1, :) = dataFrame(i, :)
        cnt1 = cnt1 + 1
    elseif dataFrame(i, 4) == "039A" then
            dF_39A(cnt2, :) = dataFrame(i, :)
            cnt2 = cnt2 + 1
    else
        dF_2B0(cnt3, :) = dataFrame(i, :)
        cnt3 = cnt3 + 1
    end
end

// Data field Identifier
num28A  = dF_28A(:, 1)
time28A = dF_28A(:, 2)
typ28A  = dF_28A(:, 3)
_ID     = dF_28A(:, 4)
len28A  = dF_28A(:, 5)
D7_28A  = dF_28A(:, 6)
D6_28A  = dF_28A(:, 7)
D5_28A  = dF_28A(:, 8)
D4_28A  = dF_28A(:, 9)
D3_28A  = dF_28A(:, 10)
D2_28A  = dF_28A(:, 11)
D1_28A  = dF_28A(:, 12)
D0_28A  = dF_28A(:, 13)

num39A  = dF_39A(:, 1)
time39A = dF_39A(:, 2)
typ39A  = dF_39A(:, 3)
__ID    = dF_39A(:, 4)
len39A  = dF_39A(:, 5)
D7_39A  = dF_39A(:, 6)
D6_39A  = dF_39A(:, 7)
D5_39A  = dF_39A(:, 8)
D4_39A  = dF_39A(:, 9)
D3_39A  = dF_39A(:, 10)
D2_39A  = dF_39A(:, 11)
D1_39A  = dF_39A(:, 12)
D0_39A  = dF_39A(:, 13)

num2B0  = dF_2B0(:, 1)
time2B0 = dF_2B0(:, 2)
typ2B0  = dF_2B0(:, 3)
___ID   = dF_2B0(:, 4)
len2B0  = dF_2B0(:, 5)
D7_2B0  = dF_2B0(:, 6)
D6_2B0  = dF_2B0(:, 7)
D5_2B0  = dF_2B0(:, 8)
D4_2B0  = dF_2B0(:, 9)
D3_2B0  = dF_2B0(:, 10)
D2_2B0  = dF_2B0(:, 11)
D1_2B0  = dF_2B0(:, 12)
D0_2B0  = dF_2B0(:, 13)

angCmd39 = hex2dec(D6_39A + D7_39A) // positive
angDat28 = hex2dec(D6_28A + D7_28A) // positive
angBps2B = hex2dec(D6_2B0 + D7_2B0) // positive

spdBps2B = hex2dec(D5_2B0) // positive

t39A = strtod(time39A)
t28A = strtod(time28A)
t2B0 = strtod(time2B0)

for j = 1:length(angCmd39)
    if angCmd39(j) > 10000 then
        angCmd39(j) = -1 * bitcmp(angCmd39(j), 16) // negative
    end
end

for k = 1:length(angDat28)
    if angDat28(k) > 10000 then
        angDat28(k) = -1 * bitcmp(angDat28(k), 16) // negative
    end
end

for l = 1:length(angBps2B)
    if angBps2B(l) > 10000 then
        angBps2B(l) = -1 * bitcmp(angBps2B(l), 16) // negative
    end
end

// =========== FIGURE ============= //

clf
figure(1, 'BackgroundColor', [1 1 1])

subplot(311)
plot(t39A, angCmd39, 'b', 'LineWidth', 3)
xgrid
xlabel('Time [ms]', 'fontsize', 3)
ylabel('Angle [0.1deg]', 'fontsize', 3)
title('Steering Position Angle_CMD (039A)', 'fontsize', 3)

subplot(312)
plot(t28A, angDat28, 'r', 'LineWidth', 3)
xgrid
xlabel('Time [ms]', 'fontsize', 3)
ylabel('Angle [0.1deg]', 'fontsize', 3)
title('Steering Position Angle_DAT (028A)', 'fontsize', 3)

subplot(313)
plot(t2B0, angBps2B, 'g', 'LineWidth', 3)
xgrid
xlabel('Time [ms]', 'fontsize', 3)
ylabel('Angle [0.1deg]', 'fontsize', 3)
title('Steering Position Angle_BPS (02B0)', 'fontsize', 3)

figure(2, 'BackgroundColor', [1 1 1])

plot(t28A, angDat28, 'r', 'LineWidth', 3)
plot(t2B0, angBps2B, 'g', 'LineWidth', 1)
xgrid
xlabel('Time [ms]', 'fontsize', 3)
ylabel('Angle [0.1deg]', 'fontsize', 3)
title('Steering Position Angle', 'fontsize', 3)
legend('DAT (ID: 028A)', 'BPS (ID: 02B0)', -5)


figure(3, 'BackgroundColor', [1 1 1])

plot(t28A, angDat28, 'r', 'LineWidth', 5)
plot(t2B0, angBps2B, 'g', 'LineWidth', 3)
plot(t39A, angCmd39, 'b', 'LineWidth', 1)
xgrid
xlabel('Time [ms]', 'fontsize', 3)
ylabel('Angle [0.1deg]', 'fontsize', 3)
title('Steering Position Angle', 'fontsize', 3)
legend('DAT (ID: 028A)', 'BPS (ID: 02B0)', 'CMD (ID: 039A)', -5)


